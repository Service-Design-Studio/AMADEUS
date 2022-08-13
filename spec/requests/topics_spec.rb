require 'rails_helper'


RSpec.describe "/topics", type: :request do
  before :each do 
    sign_in user = build(:user)
  end

  let(:valid_attributes) {{
      "name" => "test"
    }}

  let(:invalid_attributes) {{
    "name" => ""
    }}

  # describe "GET /index" do
  #   it "renders a successful response" do
  #     Topic.create! valid_attributes
  #     get topics_path
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /show" do
  #   it "renders a successful response" do
  #     topic = Topic.create! valid_attributes
  #     get topic_url(topic)
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /new" do
  #   it "renders a successful response" do
  #     get new_topic_url
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /edit" do
  #   it "renders a successful response" do
  #     topic = Topic.create! valid_attributes
  #     get edit_topic_url(topic)
  #     expect(response).to be_successful
  #   end
  # end

  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new Topic" do
  #       expect {
  #         post topics_url, params: { topic: valid_attributes }
  #       }.to change(Topic, :count).by(1)
  #     end

  #     it "redirects to all topics" do
  #       post topics_url, params: { topic: valid_attributes }
  #       expect(response).to redirect_to(topics_path)
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "does not create a new Topic" do
  #       expect {
  #         post topics_url, params: { topic: invalid_attributes }
  #       }.to change(Topic, :count).by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post topics_url, params: { topic: invalid_attributes }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {{
        "name" => "test1"
      }}

      it "updates the requested tag" do
        topic = Topic.create! valid_attributes
        patch topic_url(topic), params: { topic: new_attributes }
        topic.reload
        expect(flash[:danger]).to be_nil
      end

      it "redirects to the tag" do
        topic = Topic.create! valid_attributes
        patch topic_url(topic), params: { topic: new_attributes }
        topic.reload
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        topic = Topic.create! valid_attributes
        patch topic_url(topic), params: { topic: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe "DELETE /destroy" do
  #   it "destroys the requested tag" do
  #     topic = Topic.create! valid_attributes
  #     expect {
  #       delete topic_url(topic)
  #     }.to change(Topic, :count).by(-1)
  #   end

  #   it "redirects to the topics list" do
  #     topic = Topic.create! valid_attributes
  #     delete topic_url(topic)
  #     expect(response).to redirect_to(topics_url)
  #   end
  # end
end
