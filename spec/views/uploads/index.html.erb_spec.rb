require 'rails_helper'

RSpec.describe "uploads/index", type: :view do
  before(:each) do
    assign(:uploads, [
      Upload.create!(
        title: "Title"
      ),
      Upload.create!(
        title: "Title"
      )
    ])
  end

  it "renders a list of uploads" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
  end
end
