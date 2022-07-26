And(/^I am viewing the upload page$/) do
  visit '/admin/uploads/new'
  expect(page).to have_current_path('/admin/uploads/new')
end

## View
Then(/^I should see an area to input my Topic$/) do
  expect(page).to have_css('input[type="text"]')
end


And(/^I should see an area to upload my zip files either by browsing or dragging$/) do
  expect(page).to have_button 'create-upload-button'
  expect(page).to have_field(:file)
end



## Upload funtionalities
When(/^I attach a zip file called (.*) and key in the topic (.*)$/) do |zip_name, topic_name|
  attach_file(Rails.root + "app/assets/test_zip/#{zip_name}")
  fill_in :title, with: topic_name
end

Then(/^I click on the "Create Upload" button$/) do
  find("#create-upload-button").click
end

And(/^I should be redirected to upload database$/) do
  visit '/admin/uploads'
end

And(/^I should see the above (.*) zip file with its corresponding (.*)$/) do |zip_name, topic_name|
  expect(page).to have_current_path('/admin/uploads')
  expect(page).to have_content(topic_name)
  if zip_name == "rus.zip"
    articles = [
      "Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf",
      "Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf"
    ]
  elsif zip_name == "uav.zip"
    articles = [
      "Combat drones_ We are in a new era of warfare - here's why - BBC News.pdf",
      "Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News.pdf"
    ]
  elsif zip_name == "ukr.zip"
    articles = [
      "How many Ukrainian refugees are there and where have they gone_ - BBC News.pdf",
      "Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf"
    ]
  end

  articles.each do |article|
    expect(page).to have_content(article)
  end


end

When(/^I attach no zip file and key in the topic (.*)$/) do |topic_name|
  expect(page).to have_current_path('/admin/uploads/new')
  fill_in :title, with: topic_name
end

And(/^I should remain in this upload page$/) do
  expect(page).to have_current_path('/admin/uploads')
end

When(/^I click "Back to Upload Database" button$/) do
  find("#back-to-database").click
end

Then(/^I am redirected back to upload database page$/) do
  visit '/admin/uploads'
  expect(page).to have_current_path('/admin/uploads')
end