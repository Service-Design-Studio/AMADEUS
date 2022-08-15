Given(/^I am viewing the article "([^"]*)"$/) do |article_name|
  id = capybara_get_article_idx(article_name)
  visit("/uploads/#{id}")
  expect(page).to have_current_path("/uploads/#{id}")
end

Then(/^I should be redirected to the linking page for the tag "([^"]*)"$/) do |tag_name|
  id = capybara_get_tag_idx(tag_name)
  visit("/upload_tag_links/#{id}")
  expect(page).to have_current_path("/upload_tag_links/#{id}")
end

When(/^I click on the linking tag "([^"]*)"$/) do |tag_name|
  find("##{tag_name}-link").click
end

Then(/^I should see the following suggested articles:$/) do |db|
  db.hashes.each do |file|
    expect(page).to have_content(file[:article_name])
  end
end
