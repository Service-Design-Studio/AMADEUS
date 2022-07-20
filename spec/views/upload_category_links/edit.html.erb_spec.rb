require 'rails_helper'

RSpec.describe "upload_category_links/edit", type: :view do
  before(:each) do
    @upload_category_link = assign(:upload_category_link, UploadCategoryLink.create!())
  end

  it "renders the edit upload_category_link form" do
    render

    assert_select "form[action=?][method=?]", upload_category_link_path(@upload_category_link), "post" do
    end
  end
end
