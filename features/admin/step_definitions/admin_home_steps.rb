Given(/^I am logged in as admin of Amadeus$/) do
  capybara_login('admin123@admin.com', 'admin123')
  visit '/admin'
  expect(page).to have_current_path('/admin')
end

Then(/^I should see options for me to set topics, upload and edit articles$/) do
  expect(page).to have_current_path('/admin/uploads')
end

When(/^I select feature (.*)$/) do |feature_name|
  if feature_name == "Topic List"
    find("#topic-list-link").click
  elsif feature_name == "New Upload"
    find("#new-upload-link").click
  elsif feature_name == "Upload Database"
    find("#upload-database-link").click
  end
end

Then(/^I should be redirected to (.*) page$/) do |feature_name|
  if feature_name == "Topic List"
    expect(page).to have_current_path('/admin/topics')
  elsif feature_name == "New Upload"
    expect(page).to have_current_path('/admin/uploads/new')
  elsif feature_name == "Upload Database"
    expect(page).to have_current_path('/admin/uploads')
  end
end

