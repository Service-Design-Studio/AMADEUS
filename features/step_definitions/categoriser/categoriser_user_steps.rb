And(/^the following categories have been created: "([^"]*)"$/) do |categories|
  category_bank = categories.split(', ')
  capybara_set_categories(category_bank)
end

And(/^the following zip files have been uploaded: (.*)$/) do |zip_lists|
  zips = zip_lists.split(', ')
  zips.each do |zip_name|
    capybara_upload_zip(zip_name)
  end
end

Then(/^I should see a sidebar with the following categories: "([^"]*)"$/) do |categories|
  category_bank = categories.split(', ')
  category_bank.each do |category_name|
    expect(page).to have_content(category_name)
  end
end

Then(/^I should see no articles$/) do
  expect(page).to_not have_content("BBC News")
end

And(/^I should see a message "([^"]*)"$/) do |msg|
  expect(page).to have_content(msg)
end

When(/^I click on the article "([^"]*)"$/) do |article_name|
  id = capybara_get_article_idx(article_name)
  find("#upload-#{id}").click
  expect(page).to have_current_path("/uploads/#{id}")
end

Then(/^I should be redirected to the article "([^"]*)" page$/) do |arg|
  id = capybara_get_article_idx(article_name)
  expect(page).to have_current_path("/admin/uploads/#{id}/edit")
end