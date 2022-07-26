And(/^the following categories have been created: "([^"]*)"$/) do |categories|
  category_bank = categories.split(', ')
  capybara_set_categories(category_bank)
end

And(/^the following zip files have been uploaded: (.*)$/) do |zip_lists|
  zips = zip_lists.split(', ')
  zips.each do |zip_name|
    capybara_upload_zip(zip_name)
  end
end

Then(/^I should see a sidebar with the following categories: "([^"]*)"$/) do |categories|
  category_bank = categories.split(', ')
  category_bank.each do |category_name|
    expect(page).to have_content(category_name)
  end
end

Then(/^I should see no articles$/) do
  expect(page).to_not have_content("BBC News")
end

And(/^I should see a message "([^"]*)"$/) do |msg|
  expect(page).to have_content(msg)
end

When(/^I click on the article "([^"]*)"$/) do |article_name|
  case article_name
  when "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    find("#upload-1").click
    expect(page).to have_current_path("/uploads/1")
  when "Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf"
    find("#upload-2").click
    expect(page).to have_current_path("uploads/2")
  when "uav-Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News.pdf"
    find("#upload-3").click
    expect(page).to have_current_path("uploads/3")
  when "uav-Combat drones_ We are in a new era of warfare - here's why - BBC News.pdf"
    find("#upload-4").click
    expect(page).to have_current_path("uploads/4")
  when "How many Ukrainian refugees are there and where have they gone_ - BBC News.pdff"
    find("#upload-5").click
    expect(page).to have_current_path("uploads/5")
  when "Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf"
    find("#upload-6").click
    expect(page).to have_current_path("uploads/6")
  end
end