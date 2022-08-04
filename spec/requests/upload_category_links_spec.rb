require 'rails_helper'

RSpec.describe "/upload_category_links", type: :request do
  path = Rails.root + "app/assets/test_zip/rus.zip"
  path_fail = Rails.root + "spec/support/assets/big_chungus.jpg"
  let(:valid_attributes) {{ 
    "file" => Rack::Test::UploadedFile.new(path),
    "uploadlinks" => [Uploadlink.new(topic: Topic.new(:name => "test")), Uploadlink.new(topic: Topic.new(:name => "test2"))],
    "topics" => [Topic.new(:name => "hello")]
    # "categories" => [Category.new(:name => "test"),Category.new(:name => "test2")],
    # "topics" => [Topic.new(:name => "test"),Topic.new(:name => "test2")]
  }}
  let(:invalid_attributes) {
    { 
      "file" => Rack::Test::UploadedFile.new(path_fail),
      "uploadlinks" => [Uploadlink.new(topic: Topic.new(:name => "!!!")), Uploadlink.new(topic: Topic.new(:name => "!!!@"))],
      "topics" => [Topic.new(:name => "hello!"),Topic.new(:name => "hello2!!")]
    }}
  before :each do 
    sign_in user = build(:user)
  end
  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {{ 
        "file" => Rack::Test::UploadedFile.new(path),
        "uploadlinks" => [Uploadlink.new(topic: Topic.new(:name => "test")), Uploadlink.new(topic: Topic.new(:name => "test2"))],
        "topics" => ["hello"]
        # "categories" => [Category.new(:name => "test"),Category.new(:name => "test2")],
        # "topics" => [Topic.new(:name => "test"),Topic.new(:name => "test2")]
      }}

      it "updates the requested upload" do
        upload = UploadCategoryLink.create! valid_attributes
        patch upload_category_link_url(upload_category_link), params: { :format => 'html', upload: new_attributes }
        upload_category_link.reload
        expect(flash[:danger]).to be_nil
      end
      it "redirects to the upload" do
        upload = Upload.create! valid_attributes
        patch upload_category_link_url(upload_category_link), params: { upload: new_attributes }
        upload_category_link.reload
        expect(response).to redirect_to(edit_upload_path)
      end
    end

    context "with invalid parameters" do
      it "return Unprocessable Entity" do                         
        upload = Upload.create! valid_attributes
        patch upload_url(upload), params: { upload: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe "DELETE /destroy" do
    it "destroys the requested upload_category_link" do
      upload = Upload.create! valid_attributes
      cat = Category.create!
      upload_category_link = UploadCategoryLink.create!({"upload": upload, "category": cat})
      expect {
        delete upload_category_link_url(upload_category_link)
      }.to change(UploadCategoryLink, :count).by(-1)
    end

    it "redirects to the upload_category_links list" do
      upload = Upload.create! valid_attributes
      cat = Category.create!
      upload_category_link = UploadCategoryLink.create!({"upload": upload, "category": cat})
      delete upload_category_link_url(upload_category_link)
      expect(response).to redirect_to(edit_upload_path)
    end
  end
end