And(/^I am viewing topic list page$/) do
  visit '/admin/topics'
  expect(page).to have_current_path('/admin/topics')
end

Then(/^I should see the following topics (.*)$/) do |topic_list|
  topics = topic_list.split(', ')
  topics.each do |topic|
    expect(page).to have_content(topic)
  end
end

And(/^the option to edit and add topics$/) do
  expect(page).to have_button('#new-upload-button')
  expect(page).to have_button('#back-to-home')
end

When(/^I click on the "([^"]*)" button$/) do |arg|
  find("#new-upload-button").click
end

When(/^I click on the UAV button$/) do
  pending
end