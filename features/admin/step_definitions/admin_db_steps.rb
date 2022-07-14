And(/^I have uploaded these zip files (.*)$/) do |zip_lists|
  zips = zip_lists.split(', ')
  zips.each do |zip_name|
    capybara_upload_zip(zip_name)
  end
end

Then(/^I should see the following files$/) do |db|
  db.hashes.each do |file|
    expect(page).to have_content(file[:file_name])
  end
end

