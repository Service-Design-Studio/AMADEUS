Then(/^I should see the following categories: "([^"]*)"$/) do |categories|
  category_bank = categories.split(', ')
  category_bank.each do |category_name|
    expect(page).to have_content(category_name)
  end
end

When(/^I type in the category "([^"]*)"$/) do |category_name|
  find("#category-input").set(category_name)
end

Then(/^I should see the category "([^"]*)" in the list of categories$/) do |category_name|
  expect(page).to have_content(category_name)
end

When(/^I am on the Edit Category page for the category "([^"]*)"$/) do |category_name|
  visit("/admin/categories/#{category_name.downcase}/edit")
  expect(page).to have_current_path("/admin/categories/#{category_name.downcase}/edit")
end

When(/^I edit the category "UAVs" into "([^"]*)"$/) do |category_name|
  find("#category-input").set(category_name)
end

Then(/^I should not see the category "([^"]*)" button$/) do |category_name|
  expect(page).to_not have_css("##{category_name}-edit-button")
end

When(/^I click on the category "([^"]*)"$/) do |category_name|
  find("##{category_name}-edit-button").click
end

When(/^I have clicked on the category "([^"]*)"$/) do |category_name|
  expect(page).to have_current_path('/')
  find("##{category_name}-edit-button").click
end

Then(/^I should be redirected to the "([^"]*)" Edit Category page$/) do |category_name|
  expect(page).to have_current_path("/admin/categories/#{category_name.downcase}/edit")
end