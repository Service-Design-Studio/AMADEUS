require 'zip'

class Upload < ApplicationRecord
  include ActionView::RecordIdentifier

  has_one_attached :file, service: :google_pdf
  validates :file, presence: true
  validates :file, file_content_type: { allow: ['application/pdf', 'application/zip'], message: "ZIP should contain PDFs only!" }
  has_many :uploadlinks, dependent: :destroy
  has_many :topics, through: :uploadlinks
  has_many :upload_category_links, dependent: :destroy
  has_many :categories, through: :upload_category_links

  after_create_commit lambda {
    broadcast_prepend_later_to "uploads_list", target: "uploads", partial: "uploads/upload"
  }

  after_update_commit lambda {
    broadcast_replace_later_to "uploads_list", target: "#{dom_id self}", partial: "uploads/upload"
  }

  after_destroy_commit lambda {
    broadcast_remove_to "uploads_list", target: "#{dom_id self}"
  }

  private

  def self.verify_tag(upload, topic_name, entity_type)
    status = "fail"

    upload.uploadlinks.each do |uploadlink|
      # if the topic is already linked to the upload
      if uploadlink.topic.name == topic_name
        status = "exist"
      end
    end

    # if topic_name contains invalid inputs
    if (topic_name == "") || topic_name.nil?
      msg = flash_message_tag::INVALID_TAG
    elsif topic_name.length >= 15
      msg = flash_message_tag::INVALID_TAG
    elsif topic_name.match(/\W/)
      msg = flash_message_tag::INVALID_TAG

    # if topic already exists
    elsif status == "exist"
      msg = flash_message_tag.get_duplicate_tag(topic_name)
    
    # Checking entity_type
    else
      existing_topic = Topic.friendly.find_by(name: topic_name)
      # Did not specify entity_type
      if entity_type == "all"
        # If topic does not exist
        if existing_topic.nil?
          msg = "Please select a tag type!"
        # If topic exists
        else
          status = "success"
          msg = flash_message_tag.get_existing_added_tag(topic_name, existing_topic.entity_type)
          Uploadlink.create(upload_id: upload.id, topic_id: existing_topic.id)
        end
      # Specified entity_type
      else
        # If topic exists and is of different entity_type
        if ((!existing_topic.nil?) && (existing_topic.entity_type != entity_type))
          msg = flash_message_tag.get_duplicated_tag_name(topic_name, existing_topic.entity_type)
        # If topic exists and is of same entity_type
        elsif ((!existing_topic.nil?) && (existing_topic.entity_type == entity_type))
          status = "success"
          msg = flash_message_tag.get_existing_added_tag(topic_name, existing_topic.entity_type)
          Uploadlink.create(upload_id: upload.id, topic_id: existing_topic.id)
        # If topic does not exist
        else
          status = "success"
          msg = flash_message_tag.get_new_added_tag(topic_name, entity_type)
          new_topic = Topic.create(name: topic_name, entity_type: entity_type)
          Uploadlink.create(upload_id: upload.id, topic_id: new_topic.id)
        end
      end  
    end

    # else
    #   status = "success"
    #   msg = ""
    #   new_topic = Topic.friendly.find_by(name: topic_name)
    #   if new_topic.nil?
    #     new_topic = Topic.create(name: topic_name)
    #     Uploadlink.create(upload_id: upload.id, topic_id: new_topic.id)
    #   else
    #     Uploadlink.create(upload_id: upload.id, topic_id: new_topic.id)
    #   end
    # end
    
    return { status: status, msg: msg }
  end

  def self.verify_category(upload, category_name)
    status = "fail"

    linked_category = get_linked_category(upload)
    if !linked_category.nil? and linked_category.category.name == category_name
      status = "exist"
    end

    if (category_name == "") || category_name.nil?
      msg = flash_message_category::INVALID_CAT
    elsif category_name.length >= 30
      msg = flash_message_category::INVALID_CAT
    elsif !category_name.match(/^[a-zA-Z0-9_ ]*$/)
      msg = flash_message_category::INVALID_CAT
    elsif status == "exist"
      msg = flash_message_category.get_already_assigned_category(category_name)
    else
      status = "success"
      new_category = Category.find_by(name: category_name)
      if !linked_category.nil?
        get_linked_category(upload).destroy
      end
      if new_category.nil?
        new_category = Category.create(name: category_name)
        UploadCategoryLink.create(upload_id: upload.id, category_id: new_category.id)
        msg = flash_message_category.get_added_category(new_category[:name])
      else
        UploadCategoryLink.create(upload_id: upload.id, category_id: new_category.id)
        msg = flash_message_category.get_linked_category(new_category[:name])
      end
    end
    return { status: status, msg: msg }
  end

  def self.verify_summary(upload, summary)
    status = "fail"
    if (summary == "" || summary.nil?)
      msg = flash_message_summary::INVALID_SUMMARY
    elsif summary.split.size < 10 || summary.split.size > 100
      msg = flash_message_summary::INVALID_SUMMARY
    else
      status = "success"
      msg = flash_message_summary::SUMMARY_UPDATED
      upload.update(summary: summary)
    end
    return { status: status, msg: msg }
  end

  # SIDEKIQ - creates a zip_upload
  def self.save_zip_before_ML(file, params)
    # attach zip file in active records
    if File.extname(file) == ".zip"
      new_zip = ZipUpload.new
      new_zip.file.attach(io: StringIO.new(file.read), filename: file.original_filename)
      new_zip.save
      # get the zip file id
      zip_id = new_zip.id
      # get the zip file name
      zip_name = new_zip.file.filename
      return { zip_id: zip_id, zip_name: zip_name }
    end
    @params = params
  end

  # SIDEKIQ - runs the nltk model
  def self.run_nltk_async(upload_id)
    upload = Upload.find(upload_id)
    content = upload.content
    # nltk_response = NltkModel.request(content)
    # summary = nltk_response[:summary]
    # tags_dict = nltk_response[:tags]
    # category = nltk_response[:category]
    zero_shot_response = ZeroShotCategoriser.request(content, Category.get_category_bank)
    category = zero_shot_response[:category]
    summariser_response = Summariser.request(content)
    summary = summariser_response[:summary]
    entities_response = GoogleEntityTagger.request(content)
    tags_dict = entities_response[:entities]
    upload.summary = summary.gsub(/(\\\")/, "")
    upload.ml_status = "Complete"
    upload.save
    set_upload_tag(upload.id, tags_dict)
    if category != "No Category"
      set_upload_category(upload.id, category)
    end
  end

  def self.unzip_file_sync(file, params)
    if File.extname(file) == '.zip'
      Zip::File.open(file) do |zipfile|
        zipfile.each do |entry|
          if entry.file? && entry.to_s.include?(".pdf")
            new_upload = Upload.new
            new_upload.file.attach(io: StringIO.new(entry.get_input_stream.read), filename: entry.name)
            content = ExtractPdf.get_pdf_text(entry)
            nltk_response = NltkModel.request(content)
            summary = nltk_response[:summary]
            tags_dict = nltk_response[:tags]
            category = nltk_response[:category]
            # zero_shot_response = ZeroShotCategoriser.request(content, Category.get_category_bank)
            # category = zero_shot_response[:category]
            # summariser_response = Summariser.request(content)
            # summary = summariser_response[:summary]
            # entities_response = GoogleEntityTagger.request(content)
            # tags_dict = entities_response[:entities]
            new_upload.summary = summary.gsub(/(\\\")/, "")
            new_upload.ml_status = "Complete"
            new_upload.save
            set_upload_tag(new_upload.id, tags_dict)
            if category != "No Category"
              set_upload_category(new_upload.id, category)
            end
          end
        end
      end
    end
    @params = params
  end

  def self.set_upload_tag(upload_id, tags_dict)
    tags_dict.each do |name, entity_type|
      new_topic = Topic.friendly.find_by(name: name)
      entity_type = entity_type.gsub(/_/, " ")
      if new_topic.nil?
        new_topic = Topic.new(name: name, entity_type: entity_type)
        new_topic.save!
        Uploadlink.create(upload_id: upload_id, topic_id: new_topic.id)
      else
        Uploadlink.create(upload_id: upload_id, topic_id: new_topic.id)
      end
    end
  end

  def self.set_upload_category(upload_id, category)
    new_category = Category.friendly.find_by(name: category)
    if new_category.nil?
      new_category = Category.new(:name => category)
      new_category.save!
      UploadCategoryLink.create(upload_id: upload_id, category_id: new_category.id)
    else
      UploadCategoryLink.create(upload_id: upload_id, category_id: new_category.id)
    end
  end

  # Generates random upload_links associated to the upload, remove when ML is implemented
  def self.seed_pdf_tag(upload_id)
    topic_ids = Topic.pluck(:id)
    n = Random.rand(1...topic_ids.length)
    n.times do
      topic_id = topic_ids.sample
      Uploadlink.create(upload_id: upload_id, topic_id: topic_id)
      topic_ids.delete(topic_id)
    end
  end

  def self.get_all_topics
    Topic.all.collect(&:name)
  end

  def self.get_all_categories
    Category.all.collect(&:name)
  end

  def self.get_linked_topics(upload)
    upload.uploadlinks.all
  end

  def self.get_unlinked_topics(upload)
    topics_in_upload = upload.uploadlinks.pluck(:topic_id)
    unlinked_topics = Topic.where.not(id: topics_in_upload).sort_by(&:name)
  end

  def self.get_uploadlink(upload, topic)
    upload.uploadlinks.find_by(topic_id: topic.id)
  end

  def self.get_linked_category(upload)
    upload.upload_category_links.first
  end

  def self.get_cleaned_summary(upload)
    upload.summary.split(/\s+/, 100 + 1)[0...100].join(' ')
  end

  def self.get_cleaned_filename(upload)
    upload.file.filename.to_s.sub(/(?<=.)\..*/, '')
  end

  def self.flash_message
    FlashString::UploadString
  end

  def self.flash_message_tag
    FlashString::TagString
  end

  def self.flash_message_category
    FlashString::CategoryString
  end

  def self.flash_message_summary
    FlashString::SummaryString
  end
end
