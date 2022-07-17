Given(/^I am on the article "([^"]*)" page$/) do |article_name|
  steps %Q{
    Given I am on the "Database" page
    When I click edit article "#{article_name}"
    Then I should be redirected to the article "#{article_name}" page
  }
end

Then(/^I should see the following topics "([^"]*)"$/) do |topic_list|
  topics = topic_list.split(', ')
  topics.each do |topic|
    expect(page).to have_content(topic)
  end
end

When(/^I click delete button for the topic "([^"]*)"$/) do |topic_name|
  find("##{topic_name}-link").click
end

Then(/^I should not see the topic "([^"]*)"$/) do |topic_name|
  expect(page).to_not have_button("##{topic_name}-link")
end

When(/^I add the topic "([^"]*)"$/) do |topic_name|
  find("#topic-input").set(topic_name)
end

Then(/^I should see the topic "([^"]*)"$/) do |topic_name|
  expect(page).to have_content(topic_name)
end

Then(/^I should still see the same article "([^"]*)"$/) do |article_name|
  steps %Q{
    I am on the article "#{article_name}" page
  }
end

And(/^I should see a warning message "([^"]*)"$/) do |msg|
  expect(page).to have_content(msg)
end

When(/^I click on the topic "([^"]*)"$/) do |topic_name|
  find("##{topic_name}-edit-link").click
end

Then(/^I should be redirected to the "([^"]*)" edit page$/) do |topic_name|
  expect(page).to have_current_path("/admin/topics/#{topic_name.downcase}/edit")
end