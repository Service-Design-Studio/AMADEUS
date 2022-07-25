require 'rails_helper'

RSpec.describe "/upload_category_links", type: :request do

  before :each do 
    sign_in user = build(:user)
  end
  describe "DELETE /destroy" do
    it "destroys the requested upload_category_link" do
      upload_category_link = UploadCategoryLink.create!
      expect {
        delete upload_category_link_url(upload_category_link)
      }.to change(UploadCategoryLink, :count).by(-1)
    end

    it "redirects to the upload_category_links list" do
      upload_category_link = UploadCategoryLink.create!
      delete edit_upload_path(upload_category_link)
      expect(response).to redirect_to(upload_category_links_url)
    end
  end
end