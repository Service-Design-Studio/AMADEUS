And(/^I am viewing the upload database for the Russian\-Ukraine war$/) do
  visit 'admin/uploads'
end

And(/^I have uploaded these zip files into my database$/) do |table|
  # table is a table.hashes.keys # => [:zip_name]
  table.hashes.each do |upload|
    capybara_upload_zip(upload[:zip_name])
  end
end

And(/^I should see all the following articles (.*)$/) do |article|
  expect(page).to have_current_path('/admin/uploads')
end

When(/^I click on (.*) to understand more about the war$/) do |topic|
  visit('/admin/topics')
end

Then(/^I should be sent to Editing Topic page belongs to (.*)$/) do |topic|
  expect(page).to have_current_path('/admin/topics')
end

When(/^I want to remove the (.*) as I find it irrelevant$/) do |topic|
  visit('/admin/topics')
end

And(/^I press the cross next to the (.*)$/) do |topic|
  visit('/admin/topics')
end

Then(/^the (.*) should be deleted$/) do |topic|
  expect(page).to_not have_content(topic)
end


Given(/^the I want to add the following topics "([^"]*)", "([^"]*)", "([^"]*)"$/) do |arg1, arg2, arg3|
  visit('/admin/topics')
end

Then(/^"([^"]*)" is shown$/) do |arg|
  expect(page).to have_current_path('/admin/topics')
end

When(/^I click "([^"]*)" button$/) do |arg|
  expect(page).to have_current_path('/admin/uploads')
end