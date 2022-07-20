require 'zip'
require 'pdf-reader'
require 'json'

class Upload < ApplicationRecord
  require_relative 'nltk_model.rb'

  has_one_attached :file
  validates :file, presence: true
  validates :file, file_content_type: { allow: ['application/pdf','application/zip'], message: "ZIP should contain PDFs only!"}
  has_many :uploadlinks, dependent: :destroy
  has_many :topics, through: :uploadlinks
  has_many :upload_category_links, dependent: :destroy
  has_many :categories, through: :upload_category_links

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
        Uploadlink.create(upload_id: upload.id, topic_id: new_topic.id, similarity: 100)
      else
        Uploadlink.create(upload_id: upload.id, topic_id: new_topic.id, similarity: 100)
      end
    end
    return { status: status, msg: msg }
  end

  def self.unzip_file(file, params)
    if File.extname(file) == '.zip'
      Zip::File.open(file) do |zipfile|
        zipfile.each do |entry|
          if entry.file? && entry.to_s.include?(".pdf")
            new_upload = Upload.new
            new_upload.file.attach(io: StringIO.new(entry.get_input_stream.read), filename: entry.name)
            content = get_pdf_text(entry)
            response = NLTK_Model.request(content)
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
    end
    @params = params
  end

  def self.get_pdf_text(pdf)
    content = ""
    reader = PDF::Reader.new(StringIO.new(pdf.get_input_stream.read))
    reader.pages.each do |page|
      content.concat(page.text.strip.gsub!(/[\W]/, ' ').squeeze(' '))
    end
    return content.to_json
  end

  def self.set_upload_tag(upload_id, topics)
    topics.each do |topic, frequency|
      new_topic = Topic.friendly.find_by(name: topic)
      if new_topic.nil?
        new_topic = Topic.new(:name => topic)
        new_topic.save!
        similarity = Random.rand(1...100)
        Uploadlink.create(upload_id: upload_id, topic_id: new_topic.id, similarity: similarity)
      else
        Uploadlink.create(upload_id: upload_id, topic_id: new_topic.id, similarity: similarity)
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
      Uploadlink.create(upload_id: upload_id, topic_id: topic_id, similarity: similarity)
      topic_ids.delete(topic_id)
    end
  end

  def self.get_all_topics
    Topic.all.collect(&:name)
  end

  def self.get_linked_topics(upload)
    upload.uploadlinks.order(:similarity).reverse
  end

  def self.get_linked_category(upload)
    upload.upload_category_links.order(:similarity).reverse.first
  end

  def self.flash_message
    FlashString::TagString
  end
end