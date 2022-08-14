require 'rails_helper'
require 'fuzzbert'
RSpec.describe Upload, type: :model do
  path = Rails.root + "app/assets/test_zip/rus.zip"
  let(:valid_attributes) {{ 
      "file" => Rack::Test::UploadedFile.new(path),
      "uploadlinks" => [Uploadlink.new(topic: Topic.new(:name => "test")), Uploadlink.new(topic: Topic.new(:name => "test2"))],
      "topics" => [Topic.new(:name => "hello")],
      "id" => 1,
      "categories" => [Category.new(:name => "test")]
    }}

  describe 'associations' do
    it { should have_many(:uploadlinks) }
    it { should have_many(:upload_category_links) }
    it { should have_many(:categories) }
    it { should have_many(:topics) }
    it { should have_one_attached(:file) }
  end

  describe 'validations' do
    it { should validate_presence_of(:file) }
  end

  describe '.verify_tag' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.verify_tag(subject, "hello", "test")).to be_truthy}
  end

  describe '.verify_category' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.verify_category(subject, "hello")).to be_truthy}
  end

  describe '.verify_summary' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.verify_summary(subject, "hello")).to be_truthy}
  end

  describe '.save_zip_before_ML' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.save_zip_before_ML(path, "hello")).to be_truthy}
  end

  # describe '.run_nltk' do 
  #   before { Upload.create! valid_attributes }
  #   it { expect(subject.class.run_nltk(1)).to be_truthy}
  # end
  describe '.set_upload_tag' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.set_upload_tag(1, subject.topics)).to be_truthy}
  end

  # describe '.set_upload_category' do 
  #   before { Upload.create! valid_attributes }
  #   it { expect(subject.class.set_upload_category(1, subject.categories)).to be_truthy}
  # end

  describe '.seed_pdf_tag' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.seed_pdf_tag(1)).to be_truthy}
  end

  describe '.get_all_topics' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.get_all_topics).to be_truthy}
  end

  describe '.get_all_categories' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.get_all_categories).to be_truthy}
  end

  describe '.get_linked_topics' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.get_linked_topics(subject)).to be_truthy}
  end
  # describe '.get_cleaned_summary' do 
  #   before { Upload.create! valid_attributes }
  #   it { expect(subject.class.get_cleaned_summary(subject)).to be_truthy}
  # end
  describe '.get_cleaned_filename' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.get_cleaned_filename(subject)).to be_truthy}
  end
  describe '.flash_message' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.flash_message).to be_truthy}
  end
  describe '.flash_message_tag' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.flash_message_tag).to be_truthy}
  end
  describe '.flash_message_category' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.flash_message_category).to be_truthy}
  end
  describe '.flash_message_summary' do 
    before { Upload.create! valid_attributes }
    it { expect(subject.class.flash_message_summary).to be_truthy}
  end
end
