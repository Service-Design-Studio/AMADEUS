And(/^I should see an article called (.*) with (\d+) tags$/) do |article_name, tag_num|
  id = capybara_get_article_idx(article_name)
  expect(Upload.find_by(id: id).topics.all.length).to equal(tag_num)
end

And(/^the tags are actually words found from the article (.*)$/) do |article_name|
  id = capybara_get_article_idx(article_name)
  upload = Upload.find_by(id: id)
  content = upload.content
  upload.topics.each do |tag|
    expect(content.downcase.include?(tag.name)).to be true
  end
end