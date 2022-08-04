require "rails_helper"

RSpec.describe TopicsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "admin/topics").to route_to("topics#index")
    end

    it "routes to #new" do
      expect(get: "admin/topics/new").to route_to("topics#new")
    end

    it "routes to #show" do
      expect(get: "admin/topics/1").to route_to("topics#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "admin/topics/1/edit").to route_to("topics#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "admin/topics").to route_to("topics#create")
    end

    it "routes to #update via PUT" do
      expect(put: "admin/topics/1").to route_to("topics#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "admin/topics/1").to route_to("topics#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "admin/topics/1").to route_to("topics#destroy", id: "1")
    end
  end
end
