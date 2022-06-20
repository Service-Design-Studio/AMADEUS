# Background
Given(/^I want to log in as an admin of Amadeus$/) do
  visit '/sign_in'
end

# Scenario
## View
Then(/^I should see a "([^"]*)" title$/) do |title|
  expect(page).to have_content(title)
end

And(/^I should see a "([^"]*)" form that requires email and password credentials$/) do
|button_name|
  expect(page).to have_field(:email, placeholder: "steve@apple.com")
  expect(page).to have_field(:password, placeholder: "password")
  expect(page).to have_button(button_name)
end

## Login Functionalities
When(/^I fill in my credentials with Email (.*) and Password (.*)$/) do |email, password|
  fill_in :email, with: email
  fill_in :password, with: password
end

And(/^I click on the "Sign in" button$/) do
  find("#sign-in-button").click
end

Then(/^I should be logged in as admin$/) do
  expect(page).to have_current_path('/admin')
end

Then(/^I should stay on the login page$/) do
  expect(page).to have_current_path('/sign_in')
end