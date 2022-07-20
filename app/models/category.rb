class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :upload_category_links, dependent: :destroy
  has_many :uploads, through: :upload_category_links

  def self.verify(category_name)
    status = "fail"
    if (category_name == "") || category_name.nil?
      msg = flash_message::INVALID_TAG
    elsif category_name.length >= 15
      msg = flash_message::LENGTHY_TAG
    elsif category_name.match(/\W/)
      msg = flash_message.get_special_characters(category_name)
    elsif Category.exists?(name: category_name)
      msg = flash_message.get_duplicate_tag(category_name)
    else
      status = "success"
      msg = ""
    end
    return { status: status, msg: msg }
  end

  def self.flash_message
    FlashString::TagString
  end
end
