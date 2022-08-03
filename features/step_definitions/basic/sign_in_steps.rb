# Background
Given(/^I want to log in as an admin of Amadeus$/) do
  visit '/sign_in'
end

# Scenario
## View
Then(/^I should see a "([^"]*)" form that requires email and password credentials$/) do |name|
  expect(page).to have_field(:email, placeholder: "steve@apple.com")
  expect(page).to have_field(:password, placeholder: "password")
  expect(page).to have_button(name)
end

## Login Functionalities
When(/^I sign in with correct credentials Email (.*) and password (.*)$/) do |email, password|
  capybara_login(email, password)
end

Then(/^I should be logged in as admin$/) do
  expect(page).to have_current_path('/admin')
end

When(/^I fill in my credentials with Email (.*) and Password (.*)$/) do |email, password|
  fill_in :email, with: email
  fill_in :password, with: password
  expect(page).to have_field(:email, with: email)
  expect(page).to have_field(:password, with: password)
end

And(/^I click on the "Sign in" button$/) do
  find("#sign-in-button").click
end

Then(/^I should stay on the login page$/) do
  expect(page).to have_current_path('/sign_in')
  expect(page).to have_content('Invalid Email or password.')
end

