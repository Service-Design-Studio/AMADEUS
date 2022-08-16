require "rails_helper"

RSpec.describe UploadCategoryLinksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/upload_category_links").to route_to("upload_category_links#index")
    end

    it "routes to #new" do
      expect(get: "/upload_category_links/new").to route_to("upload_category_links#new")
    end

    it "routes to #show" do
      expect(get: "/upload_category_links/1").to route_to("upload_category_links#show", id: "1")
    end



    it "routes to #create" do
      expect(post: "/upload_category_links").to route_to("upload_category_links#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/upload_category_links/1").to route_to("upload_category_links#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/upload_category_links/1").to route_to("upload_category_links#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/upload_category_links/1").to route_to("upload_category_links#destroy", id: "1")
    end
  end
end
