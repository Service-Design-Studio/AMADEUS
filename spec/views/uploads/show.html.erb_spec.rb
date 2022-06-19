require 'rails_helper'

RSpec.describe "uploads/show", type: :view do
  before(:each) do
    @upload = assign(:upload, Upload.create!(
      title: "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
