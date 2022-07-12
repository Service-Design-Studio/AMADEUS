And(/^I am viewing the upload database page$/) do
  visit '/admin/uploads/new'
  expect(page).to have_current_path('/admin/uploads/new')
end

And /I have these zip files already uploaded/ do |db|
  db.hashes.each do |upload|
    capybara_upload_zip(upload[:zip_name])
  end
end

Then(/^I should see all the uploaded zip files$/) do
  topics = %w(Russia UAV Ukraine)
  articles = [
    "Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf",
    "Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf",
    "Combat drones_ We are in a new era of warfare - here's why - BBC News.pdf",
    "Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News.pdf",
    "How many Ukrainian refugees are there and where have they gone_ - BBC News.pdf",
    "Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf",
  ]
  topics.each do |topic_name|
    expect(page).to have_content(topic_name)
  end

  articles.each do |article_name|
    expect(page).to have_content(article_name)
  end
end

When(/^I click on the "New Upload" button$/) do
  find("#new-upload-button").click
end

Then(/^I am redirected back to the upload page$/) do
  visit '/admin/uploads/new'
  expect(page).to have_current_path('/admin/uploads/new')
end