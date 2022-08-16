require "rails_helper"

RSpec.describe UploadsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "admin/uploads").to route_to("uploads#index")
    end

    it "routes to #new" do
      expect(get: "admin/uploads/new").to route_to("uploads#new")
    end

    it "routes to #edit" do
      expect(get: "admin/uploads/1/edit").to route_to("uploads#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "admin/uploads").to route_to("uploads#create")
    end

    it "routes to #update via PUT" do
      expect(put: "admin/uploads/1").to route_to("uploads#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "admin/uploads/1").to route_to("uploads#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "admin/uploads/1").to route_to("uploads#destroy", id: "1")
    end
  end
end
