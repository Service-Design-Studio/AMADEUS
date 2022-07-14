When(/^I sign in with correct credentials Email (.*) and password (.*)$/) do |email, password|
  capybara_login(email, password)
end

When(/^I fill in my credentials with Email (.*) and Password (.*)$/) do |email, password|
  fill_in :email, with: email
  fill_in :password, with: password
  expect(page).to have_field(:email, with: email)
  expect(page).to have_field(:password, with: password)
end

