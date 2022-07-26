And(/^I have created the following categories: "([^"]*)"$/) do |categories|
  category_bank = categories.split(', ')
  capybara_set_categories(category_bank)
end

And(/^I should see an article called (.*) with the category (.*)$/) do |article_name, category_name|
  expect(page).to have_content(article_name)
  expect(page).to have_content(category_name)
end

And(/^the category (.*) should be from the following list of categories "([^"]*)"$/) do |category_name, categories|
  category_bank = categories.split(', ')
  expect(category_bank.include?(category_name)).to be true
end

Given(/^I have deleted the following categories: "([^"]*)" from the list of categories$/) do |categories|
  category_bank = categories.split(', ')
  capybara_delete_categories(category_bank)
end

And(/^I have added the following categories: "([^"]*)" to the list of categories$/) do |categories|
  category_bank = categories.split(', ')
  capybara_add_categories(category_bank)
end

Given(/^I have no category in Category Bank$/) do
  capybara_remove_all_categories
end

And(/^I should see an article called (.*) with "No Category" label$/) do |article_name|
  expect(page).to have_content(article_name)
  expect(page).to have_content("No Category")
end
