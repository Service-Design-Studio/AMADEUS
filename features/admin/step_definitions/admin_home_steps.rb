Given(/^I am logged in as admin of Amadeus$/) do
  login('admin123@admin.com', 'admin123')
  visit '/admin'
  expect(page).to have_current_path('/admin')
end

Then(/^I should see options for me to set topics, upload and edit articles$/) do
  expect(page).to have_link("set-topics-link")
  expect(page).to have_link("upload-articles-link")
  expect(page).to have_link("edit-articles-link")
end

When(/^I select feature (.*)$/) do |feature_name|
  if feature_name == "Set topics"
    find("#set-topics-link").click
  elsif feature_name == "Upload Articles"
    find("#upload-articles-link").click
  elsif feature_name == "Edit Articles"
    find("#edit-articles-link").click
  end
end

Then(/^I should be redirected to (.*) page$/) do |feature_name|
  if feature_name == "Set topics"
    expect(page).to have_current_path('/admin#')
  elsif feature_name == "Upload Articles"
    expect(page).to have_current_path('/admin/uploads/new')
  elsif feature_name == "Edit Articles"
    expect(page).to have_current_path('/admin/uploads')
  end
end

