require 'rails_helper'

RSpec.describe "upload_category_links/show", type: :view do
  before(:each) do
    @upload_category_link = assign(:upload_category_link, UploadCategoryLink.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
