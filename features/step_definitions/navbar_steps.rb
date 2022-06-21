Given(/^I just open Amadeus$/) do
  visit '/'
end

## View
When(/^I click the hamburger icon$/) do
  find("#hamburger-icon").click
end

And(/^I should see the following features (.*)$/) do |feature_lists|
  features = feature_lists.split(', ')
  features.each do |feature|
    expect(page).to have_content(feature)
  end
end

## Choosing features
Given(/^the navigation bar is open$/) do
  find("#hamburger-icon").click
end

When(/^I click on the ([^"]*) feature$/) do |feature_name|
  if feature_name == "Home"
    find("#home-feature-link").click
  elsif feature_name == "Admin"
    find("#admin-feature-link").click
  elsif feature_name == "Sign Out"

  end
end

Then(/^I am redirected to the (.*) page$/) do |feature_name|
  if feature_name == "Home"
    expect(page).to have_current_path('/')
  elsif feature_name == "Admin"
    expect(page).to have_current_path('/sign_in')
  elsif feature_name == "Sign Out"
    expect(page).to have_current_path('/')
  end
end