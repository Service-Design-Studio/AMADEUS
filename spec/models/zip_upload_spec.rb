require 'rails_helper'

RSpec.describe ZipUpload, type: :model do
  path = Rails.root + "app/assets/test_zip/rus.zip"
  let(:valid_attributes) {{ 
    "file" => Rack::Test::UploadedFile.new(path),
    "id" => 1
  }}
  # before :uploadrequired do 
  #   ZipUpload.create! valid_attributes
  # end
  describe 'associations' do
    it { should have_one_attached(:file) }
  end

  describe 'validations' do
    it { should validate_presence_of(:file) }
  end

  describe '.unzip_file' do 
    before { ZipUpload.create! valid_attributes }
    it { expect(subject.class.unzip_file_async(1)).to be_truthy}
  end
end
