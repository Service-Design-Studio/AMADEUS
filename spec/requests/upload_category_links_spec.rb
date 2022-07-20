require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/upload_category_links", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # UploadCategoryLink. As you add validations to UploadCategoryLink, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      UploadCategoryLink.create! valid_attributes
      get upload_category_links_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      upload_category_link = UploadCategoryLink.create! valid_attributes
      get upload_category_link_url(upload_category_link)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_upload_category_link_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      upload_category_link = UploadCategoryLink.create! valid_attributes
      get edit_upload_category_link_url(upload_category_link)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UploadCategoryLink" do
        expect {
          post upload_category_links_url, params: { upload_category_link: valid_attributes }
        }.to change(UploadCategoryLink, :count).by(1)
      end

      it "redirects to the created upload_category_link" do
        post upload_category_links_url, params: { upload_category_link: valid_attributes }
        expect(response).to redirect_to(upload_category_link_url(UploadCategoryLink.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UploadCategoryLink" do
        expect {
          post upload_category_links_url, params: { upload_category_link: invalid_attributes }
        }.to change(UploadCategoryLink, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post upload_category_links_url, params: { upload_category_link: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested upload_category_link" do
        upload_category_link = UploadCategoryLink.create! valid_attributes
        patch upload_category_link_url(upload_category_link), params: { upload_category_link: new_attributes }
        upload_category_link.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the upload_category_link" do
        upload_category_link = UploadCategoryLink.create! valid_attributes
        patch upload_category_link_url(upload_category_link), params: { upload_category_link: new_attributes }
        upload_category_link.reload
        expect(response).to redirect_to(upload_category_link_url(upload_category_link))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        upload_category_link = UploadCategoryLink.create! valid_attributes
        patch upload_category_link_url(upload_category_link), params: { upload_category_link: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested upload_category_link" do
      upload_category_link = UploadCategoryLink.create! valid_attributes
      expect {
        delete upload_category_link_url(upload_category_link)
      }.to change(UploadCategoryLink, :count).by(-1)
    end

    it "redirects to the upload_category_links list" do
      upload_category_link = UploadCategoryLink.create! valid_attributes
      delete upload_category_link_url(upload_category_link)
      expect(response).to redirect_to(upload_category_links_url)
    end
  end
end