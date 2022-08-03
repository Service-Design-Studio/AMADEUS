class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :uploadlinks, dependent: :destroy
  has_many :uploads, through: :uploadlinks

  def self.verify(topic_name)
    status = "fail"
    if (topic_name == "") || topic_name.nil?
      msg = flash_message::INVALID_TAG
    elsif topic_name.length >= 15
      msg = flash_message::INVALID_TAG
    elsif topic_name.match(/\W/)
      msg = flash_message::INVALID_TAG
    elsif Topic.exists?(name: topic_name)
      msg = flash_message.get_duplicate_tag(topic_name)
    else
      status = "success"
      msg = ""
    end
    return { status: status, msg: msg }
  end

  def self.flash_message
    FlashString::TagString
  end

  # returns the bg-type css class for the topic
  def self.css_class_type(topic)
    topic_entity_type = topic.entity_type
    all_types = {
      "PERSON" => "bg-person",
      "LOCATION" => "bg-location",
      "ORGANIZATION" => "bg-organization",
      "EVENT" => "bg-event",
      "WORK_OF_ART" => "bg-work-of-art",
      "CONSUMER_GOOD" => "bg-consumer-good",
      "OTHER" => "bg-other"
    }
    puts "-----------------------------------------------------------------------------------------------------"
    puts "topic_type: #{topic_entity_type}"
    return all_types[topic_entity_type]
  end

end
