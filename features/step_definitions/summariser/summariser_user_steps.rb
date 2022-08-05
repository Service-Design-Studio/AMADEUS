Then(/^I should see the summary "([^"]*)" belongs to the article "([^"]*)"$/) do |summary, article_name|
  expect(page).to have_content(summary)
  expect(page).to have_content(article_name)
  id = capybara_get_article_idx(article_name)
  upload = Upload.find_by(id: id)
  expect(upload.summary == summary).to be true
end