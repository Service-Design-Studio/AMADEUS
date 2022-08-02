require 'set'

Then(/^I should see a summary between (\d+) to (\d+) words for the article "([^"]*)"$/) do |lo, hi, article_name|
  expect(page).to have_css('#summary-input')
  id = capybara_get_article_idx(article_name)
  upload = Upload.find_by(id: id)
  summary = upload.summary
  expect(page).to have_content(summary)
  expect(summary.split.size <= hi).to be true
  expect(summary.split.size >= lo).to be true
end

And(/^the summary should use words from the article "([^"]*)"$/) do |article_name|
  id = capybara_get_article_idx(article_name)
  upload = Upload.find_by(id: id)
  content_words =  upload.content.downcase.split.map{ |s| s.strip.delete("\t\r\n").gsub(/[[:punct:]]/, "") }
  summary_words =  upload.summary.downcase.split.map{ |s| s.strip.delete("\t\r\n").gsub(/[[:punct:]]/, "") }
  content_set = Set.new(content_words)
  summary_set = Set.new(summary_words)
  expect(summary_set <= content_set).to be true
end