And(/^I should see the article "([^"]*)" under the category "([^"]*)"$/) do |article_name, category_name|
  expect(page).to have_content(article_name)
  expect(page).to have_content(category_name)
end

And(/^I should see the following articles with "No Category" label:$/) do |db|
  db.hashes.each do |article|
    expect(page).to have_content(article[:article_name])
    expect(page).to have_content("No Category")
  end
end

When(/^I click on the hyperlink for the category "([^"]*)"$/) do |foo|
  find(:xpath, "//*[@id=\"category-link\"]").click
end

Then(/^I should see that the category name "([^"]*)" has not changed$/) do |category_name|
  expect(page).to have_content(category_name)
end

Then(/^I should still see the same category "([^"]*)"$/) do |category_name|
  expect(page).to have_content(category_name)
end

Then(/^I should see the new category "([^"]*)"$/) do |category_name|
  expect(page).to have_content(category_name)
end

Then(/^I should see the label "([^"]*)"$/) do |label|
  expect(page).to have_content(label)
end

And(/^I should see a form with the following categories to select from: "([^"]*)"$/) do |categories|
  category_bank = categories.split(', ')
  category_bank.each do |category_name|
    expect(page).to have_content(category_name)
  end
end

When(/^I select the category "([^"]*)"$/) do |category_name|
  find("#category-input").set(category_name)
end

When(/^I type the category name as "([^"]*)"$/) do |category_name|
  find("#category-input").set(category_name)
end

And(/^the article has not been assigned any category$/) do
  expect(Upload.find_by(id: 1)[:categories].nil?).to be true
end

Then(/^I should see the article assigned to the category "([^"]*)"$/) do |category_name|
  expect(page).to have_content(category_name)
end