And(/^I am viewing the upload database page$/) do
  visit '/admin/uploads/new'
  expect(page).to have_current_path('/admin/uploads/new')
end

And /I have these zip files already uploaded/ do |db|
  db.hashes.each do |upload|
    capybara_upload_zip(upload[:zip_name], upload[:topic_name])
  end
end

Then(/^I should see all the uploaded zip files$/) do
  db = {Russia: 'rus.zip', Ukraine: 'ukr.zip', UAV: 'UAV' }
  db.each do |zip_name, topic_name|
    expect(page).to have_content(zip_name)
    expect(page).to have_content(topic_name)
  end
end

When(/^I click on the "([^"]*)" button$/) do |arg|
  find("#new-upload-button").click
end

Then(/^I am redirected back to the upload page$/) do
  visit '/admin/uploads/new'
  expect(page).to have_current_path('/admin/uploads/new')
end