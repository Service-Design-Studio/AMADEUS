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

  # returns the bg-type css class for the topic for bagde/table row
  def self.css_class_type(topic, type)
    topic_entity_type = topic.entity_type
    all_types = {
      "PERSON" => "bg-person",
      "LOCATION" => "bg-location",
      "ORGANIZATION" => "bg-organization",
      "EVENT" => "bg-event",
      "WORK OF ART" => "bg-work-of-art",
      "CONSUMER GOOD" => "bg-consumer-good",
      "OTHER" => "bg-other"
    }
    if type == "table-row"
      return all_types[topic_entity_type] + "-table-row"
    else
      return all_types[topic_entity_type] + "-badge"
    end
  end

  # toggles the params in edit page
  def self.set_toggle_tag_type(btn_pressed, previous_tag_type)
    if btn_pressed == previous_tag_type
      return ""
    else
      return btn_pressed.gsub(" ", "_")
    end
  end

end
