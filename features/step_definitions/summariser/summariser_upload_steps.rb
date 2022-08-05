When(/^I edit the summary into "([^"]*)"$/) do |summary|
  find('#summary-input').set(summary)
end

Then(/^I should see the summary "([^"]*)"\.$/) do |summary|
  expect(page).to have_content(summary)
end

Then(/^I should still see the old summary belongs to the article "([^"]*)"$/) do |article_name|
  id = capybara_get_article_idx(article_name)
  upload = Upload.find_by(id: id)
  summary = upload.summary
  expect(page).to have_content(summary)
end