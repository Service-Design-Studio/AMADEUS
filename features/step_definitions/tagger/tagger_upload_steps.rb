Then(/^I should see the following tags: "([^"]*)"$/) do |tag_list|
  tags = tag_list.split(', ')
  tags.each do |tag|
    expect(page).to have_content(tag)
  end
end

When(/^I click delete button for the tag "([^"]*)"$/) do |tag_name|
  find("##{tag_name}-delete-button").click
end

Then(/^I should not see the tag "([^"]*)"$/) do |tag_name|
  expect(page).to_not have_button("##{tag_name}-delete-button")
end

When(/^I add the tag "([^"]*)"$/) do |tag_name|
  find("#tag-input").set(tag_name)
end

Then(/^I should see the tag "([^"]*)"$/) do |tag_name|
  expect(page).to have_content(tag_name)
end

Then(/^I should still see the same article "([^"]*)"$/) do |article_name|
  steps %Q{
    I am on the edit page for the article "#{article_name}"
  }
end

When(/^I click on the tag "([^"]*)"$/) do |tag_name|
  find("##{tag_name}-edit-button").click
end
