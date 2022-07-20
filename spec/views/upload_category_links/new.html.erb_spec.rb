require 'rails_helper'

RSpec.describe "upload_category_links/new", type: :view do
  before(:each) do
    assign(:upload_category_link, UploadCategoryLink.new())
  end

  it "renders new upload_category_link form" do
    render

    assert_select "form[action=?][method=?]", upload_category_links_path, "post" do
    end
  end
end
