require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:upload_category_links) }
    it { should have_many(:uploads) }
  end

  describe '.verify' do 
    it { expect(subject.class.verify(subject.name)).to be_truthy}
  end

  describe '.get_category_bank' do 
    it { expect(subject.class.get_category_bank).to be_truthy}
  end
  describe '.flash_message' do 
    it { expect(subject.class.flash_message).to be_truthy}
  end
end
