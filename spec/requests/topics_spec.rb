require 'rails_helper'


RSpec.describe "/tags", type: :request do
  before :each do 
    sign_in user = build(:user)
    host! "localhost:3000"
  end

  let(:valid_attributes) {{
      "name" => "test"
    }}

  let(:invalid_attributes) {{
    "name" => ""
    }}

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {{
        "name" => "test1"
      }}

      it "updates the requested tag" do
        tag = Tag.create! valid_attributes
        patch tag_url(tag), params: { tag: new_attributes }
        tag.reload
        expect(flash[:danger]).to be_nil
      end

      it "redirects to the tag" do
        tag = Tag.create! valid_attributes
        patch tag_url(tag), params: { tag: new_attributes }
        tag.reload
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        tag = Tag.create! valid_attributes
        patch tag_url(tag), params: { tag: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
