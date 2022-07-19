And(/^I the following tags have been created "Tanks Artillery UAVs Helicopters Missiles MANPADs"$/) do
  setup
end

When(/^I am on the "([^"]*)" edit page$/) do |tag_name|
  visit("/admin/topics/#{tag_name.downcase}/edit")
  expect(page).to have_current_path("/admin/topics/#{tag_name.downcase}/edit")
end

When(/^I edit the tag into "([^"]*)"$/) do |tag_name|
  find("#tag-input").set(tag_name)
end

