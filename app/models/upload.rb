require 'zip'
require 'pdf-reader'
require 'json'

class Upload < ApplicationRecord
  include ActionView::RecordIdentifier
  require_relative 'nltk_model.rb'

  has_one_attached :file
  validate :validate_attachment_filetype
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

  def self.verify(upload, topic_name)
    status = "fail"

    upload.uploadlinks.each do |uploadlink|
      if uploadlink.topic.name == topic_name
        status = "exist"
      end
    end

    if (topic_name == "") || topic_name.nil?
      msg = flash_message::INVALID_TAG
    elsif topic_name.length >= 15
      msg = flash_message::LENGTHY_TAG
    elsif topic_name.match(/\W/)
      msg = flash_message.get_special_characters(topic_name)
    elsif status == "exist"
      status = "fail"
      msg = flash_message.get_duplicate_tag(topic_name)
    else
      status = "success"
      msg = ""
      new_topic = Topic.friendly.find_by(name: topic_name)
      if new_topic.nil?
        new_topic = Topic.create(name: topic_name)
        Uploadlink.create(upload_id: upload.id, topic_id: new_topic.id)
      else
        Uploadlink.create(upload_id: upload.id, topic_id: new_topic.id)
      end
    end
    return { status: status, msg: msg }
  end

  def validate_attachment_filetype
    return unless file.attached?

    unless file.content_type.in?(%w[application/pdf])
      errors.add(:file, 'must be a ZIP!')
    end
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
  def self.run_nltk(upload_id)
    upload = Upload.find(upload_id)
    content = upload.content
    nltk_response = NltkModel.request(content)
    summary = nltk_response[:summary].gsub(/(\\\")/, "")
    tags_dict = nltk_response[:tags]
    category = nltk_response[:category]
    # zero_shot_response = ZeroShotCategoriser.request(summary, Category.get_category_bank)
    # category = zero_shot_response[:category]
    upload.content = content
    upload.summary = summary
    upload.ml_status = "Complete"
    upload.save
    set_upload_tag(upload.id, tags_dict)
    if category != "No Category"
      set_upload_category(upload.id, category)
    end
  end

  # old function without sidekiq
  def self.unzip_file(file, params)
    Zip::File.open(file) do |zipfile|
      zipfile.each do |entry|
        if entry.file?
          new_upload = Upload.new
          new_upload.file.attach(io: StringIO.new(entry.get_input_stream.read), filename: entry.name)
          content = get_pdf_text(entry)
          response = NltkModel.request(content)
          summary = response[:summary]
          tags_dict = response[:tags]
          category = response[:category]
          new_upload.content = content
          new_upload.summary = summary
          new_upload.save
          set_upload_tag(new_upload.id, tags_dict)
          set_upload_category(new_upload.id, category)
        end
      end
    end
    @params = params
  end

  def self.get_pdf_text(pdf)
    content = ""
    reader = PDF::Reader.new(StringIO.new(pdf.get_input_stream.read))
    reader.pages.each do |page|
      content.concat(page.text.strip.gsub("\n", ' ').squeeze(' '))
    end
    return content.to_json
  end

  def self.set_upload_tag(upload_id, topics)
    topics.each do |topic, frequency|
      new_topic = Topic.friendly.find_by(name: topic)
      if new_topic.nil?
        new_topic = Topic.new(:name => topic)
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
      similarity = Random.rand(1...100)
      Uploadlink.create(upload_id: upload_id, topic_id: topic_id)
      topic_ids.delete(topic_id)
    end
  end

  def self.get_all_topics
    Topic.all.collect(&:name)
  end

  def self.get_linked_topics(upload)
    upload.uploadlinks.all
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
    FlashString::TagString
  end
end