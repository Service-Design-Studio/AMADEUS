When(/^I click edit article "([^"]*)"$/) do |article_name|
  expect(page).to have_content(article_name)
  id = capybara_get_article_idx(article_name)
  find("#upload-#{id}").click
  expect(page).to have_current_path("/admin/uploads/#{id}/edit")
end

Then(/^I should be redirected to the article "([^"]*)" edit page$/) do |article_name|
  id = capybara_get_article_idx(article_name)
  expect(page).to have_current_path("/admin/uploads/#{id}/edit")
end
