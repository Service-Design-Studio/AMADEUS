require 'rails_helper'

RSpec.describe "upload_category_links/index", type: :view do
  before(:each) do
    assign(:upload_category_links, [
      UploadCategoryLink.create!(),
      UploadCategoryLink.create!()
    ])
  end

  it "renders a list of upload_category_links" do
    render
  end
end
