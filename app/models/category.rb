class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :upload_category_links, dependent: :destroy
  has_many :uploads, through: :upload_category_links

  def self.verify(category_name)
    status = "fail"
    if (category_name == "") || category_name.nil?
      msg = flash_message::INVALID_CAT
    elsif category_name.length >= 15
      msg = flash_message::LENGTHY_CAT
    elsif category_name.match(/\W/)
      msg = flash_message.get_special_characters(category_name)
    elsif Category.exists?(name: category_name)
      msg = flash_message.get_duplicate_category(category_name)
    else
      status = "success"
      msg = ""
    end
    return { status: status, msg: msg }
  end

  def self.flash_message
    FlashString::CategoryString
  end

  def self.get_category_bank
    %w[Tanks Artillery UAVs Helicopters Missiles MANPADs Infrastructure]
  end
end
