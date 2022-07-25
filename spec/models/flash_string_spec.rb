require 'rails_helper'

RSpec.describe FlashString::TagString, type: :model do
  it "adds tag" do
    expect(FlashString::TagString.get_added_tag("hi")).to eq("hi added.")
  end
  it "updated tag" do
    expect(FlashString::TagString.get_updated_tag("hi", "hello")).to eq("hi updated into hello.")
  end
  it "deletes tag" do
    expect(FlashString::TagString.get_deleted_tag("um")).to eq("Deleted um.")
  end
  it "gets special char" do
    expect(FlashString::TagString.get_special_characters("um")).to eq("Tag um contains special characters!")
  end 
  it "deletes tag" do
    expect(FlashString::TagString.get_deleted_tag("um")).to eq("Deleted um.")
  end
  it "gets space" do
    expect(FlashString::TagString.get_space("um")).to eq("Tag um starts or ends with a space!")
  end
end