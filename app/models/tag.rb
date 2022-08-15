class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :upload_tag_links, dependent: :destroy
  has_many :uploads, through: :upload_tag_links

  def self.verify(tag_name)
    status = "fail"
    if (tag_name == "") || tag_name.nil?
      msg = flash_message::INVALID_TAG
    elsif tag_name.length >= 15
      msg = flash_message::INVALID_TAG
    elsif tag_name.match(/\W/)
      msg = flash_message::INVALID_TAG
    elsif Tag.exists?(name: tag_name)
      msg = flash_message.get_duplicate_tag(tag_name)
    else
      status = "success"
      msg = ""
    end
    return { status: status, msg: msg }
  end

  def self.flash_message
    FlashString::TagString
  end

  # returns the bg-type css class for the tag for bagde/table row
  def self.css_class_type(tag, type)
    tag_entity_type = tag.entity_type
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
      return all_types[tag_entity_type] + "-table-row"
    else
      return all_types[tag_entity_type] + "-badge"
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
