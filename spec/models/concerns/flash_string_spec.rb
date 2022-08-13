require 'rails_helper'

RSpec.describe FlashString::TagString do

  describe '.get_added_tag' do
    it { expect(subject.class.get_added_tag("hello")).to be_truthy}
  end
  describe '.get_deleted_tag' do
    it { expect(subject.class.get_deleted_tag("hello")).to be_truthy}
  end
  describe '.get_duplicate_tag' do
    it { expect(subject.class.get_duplicate_tag("hello")).to be_truthy}
  end
  
end

RSpec.describe FlashString::CategoryString do

    describe '.get_added_category' do
      it { expect(subject.class.get_added_category("hello")).to be_truthy}
    end
    describe '.get_linked_category' do
      it { expect(subject.class.get_linked_category("hello")).to be_truthy}
    end
    describe '.get_deleted_category' do
      it { expect(subject.class.get_deleted_category("hello")).to be_truthy}
    end
    describe '.get_duplicate_category' do
        it { expect(subject.class.get_duplicate_category("hello")).to be_truthy}
    end
    describe '.get_already_assigned_category' do
        it { expect(subject.class.get_already_assigned_category("hello")).to be_truthy}
    end
    
  end
