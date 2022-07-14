And(/^I should see an area to upload my zip files either by browsing or dragging$/) do
  expect(page).to have_field(:file)
end

When(/^I attach a zip file called (.*)$/) do |zip_name|
  attach_file(Rails.root + "app/assets/test_zip/#{zip_name}")
end

And(/^I should see a file called (.*)$/) do |file_name|
  expect(page).to have_content(file_name)
end

When(/^I attach no zip file and upload$/) do
  capybara_upload_zip("")
end

