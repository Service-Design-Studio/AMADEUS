Given(/^I am logged in as admin of Amadeus$/) do
  capybara_login('admin123@admin.com', 'admin123')
  visit '/admin'
  expect(page).to have_current_path('/admin')
end

Given(/^I am a regular user$/) do
  capybara_logout
  visit '/'
  expect(page).to have_current_path('/')
end

Given(/^I am on the "(.*)" page$/) do |page_name|
  case page_name
  when "Home"
    visit '/'
    expect(page).to have_current_path('/')
  when "Sign In"
    visit '/sign_in'
    expect(page).to have_current_path('/sign_in')
  when "Database"
    visit '/admin/uploads'
    expect(page).to have_current_path('/admin/uploads')
  when "Upload"
    visit '/admin/uploads/new'
    expect(page).to have_current_path('/admin/uploads/new')
  else
    visit('/')
  end
end

When(/^I click on the "([^"]*)" button$/) do |button_name|
  case button_name
  when "Home"
    find("#home-feature-link").click
  when "Admin"
    find("#admin-feature-link").click
  when "Sign In"
    find("#sign-in-button").click
  when "Sign Out"
    capybara_logout
    visit('/')
  when "Upload"
    find("#upload-button").click
  when "Topic List"
    find("#topic-list-link").click
  when "New Upload"
    find("#new-upload-link").click
  when "Database"
    find("#upload-database-link").click
  when "Back to Home"
    find("#back-to-home-link").click
  else
    find("#index-link").click
  end
end

Then(/^I should be redirected to the "(.*)" page$/) do |page_name|
  case page_name
  when "Home"
    expect(page).to have_current_path('/')
  when "Sign Out"
    expect(page).to have_current_path('/')
  when "Sign In"
    expect(page).to have_current_path('/sign_in')
  when "Admin Home"
    expect(page).to have_current_path('/sign_in')
  when "Admin"
    expect(page).to have_current_path('/admin')
  when "Topic List"
    expect(page).to have_current_path('/admin/topics')
  when "Upload"
    expect(page).to have_current_path('/admin/uploads/new')
  when "New Upload"
    expect(page).to have_current_path('/admin/uploads/new')
  when "Upload Database"
    expect(page).to have_current_path('/admin/uploads')
  when "Database"
    expect(page).to have_current_path('/admin/uploads')
  else
    expect(page).to have_current_path('/')
  end
end

Then(/^I should stay on the "(.*)" page$/) do |page_name|
  case page_name
  when "Home"
    expect(page).to have_current_path('/')
  when "Admin"
    expect(page).to have_current_path('/admin')
  when "Upload"
    expect(page).to have_current_path('/admin/uploads/new')
  else
    expect(page).to have_current_path('/')
  end
end

Then(/^I should see a "([^"]*)" form with the following fields "Email", "Password"$/) do |form_name|
  case form_name
  when "Sign In"
    expect(page).to have_field(:email, placeholder: "steve@apple.com")
    expect(page).to have_field(:password, placeholder: "password")
  else
    pending
  end
end

And(/^I should see the following buttons "([^"]*)"$/) do |button_lists|
  buttons = button_lists.split(', ')
  buttons.each do |button|
    expect(page).to have_content(button)
  end
end

And(/^I should see a "([^"]*)" button$/) do |button_name|
  expect(page).to have_content(button_name)
end
