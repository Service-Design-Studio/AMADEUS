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

Given(/^I am on the "([^"]*)" page$/) do |page_name|
  page_name = page_name.to_sym
  if CapybaraHelper::PAGE_MAP.key?(page_name)
    route = CapybaraHelper::PAGE_MAP[page_name]
  else
    route = '/'
  end
  visit(route)
  expect(page).to have_current_path(route)
end

Then(/^I should be redirected to the "([^"]*)" page$/) do |page_name|
  steps %Q{ I should stay on the "#{page_name}" page }
end

Then(/^I should stay on the "([^"]*)" page$/) do |page_name|
  page_name = page_name.to_sym
  if CapybaraHelper::PAGE_MAP.key?(page_name)
    route = CapybaraHelper::PAGE_MAP[page_name]
  else
    route = '/'
  end
  expect(page).to have_current_path(route)
end

When(/^I have uploaded these zip files (.*)$/) do |zip_lists|
  zips = zip_lists.split(', ')
  zips.each do |zip_name|
    capybara_upload_zip(zip_name)
  end
end

When(/^I click on the "([^"]*)" button$/) do |button_name|
  button_name = button_name.to_sym
  if CapybaraHelper::BUTTON_MAP.key?(button_name)
    button = CapybaraHelper::BUTTON_MAP[button_name]
    find(:xpath, "//*[@id=\"#{button}\"]").click
  elsif CapybaraHelper::FORM_BUTTON_MAP.key?(button_name)
    button = CapybaraHelper::FORM_BUTTON_MAP[button_name]
    find(:xpath, "//*[@id=\"#{button}\"]").click
  elsif button_name == "Sign Out"
    capybara_logout
    visit('/')
  else
    pending
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

And(/^I should see the following buttons "([^"]*)"$/) do |button_list|
  buttons = button_list.split(', ')
  buttons.each do |button_name|
    button_name = button_name.to_sym
    if CapybaraHelper::BUTTON_MAP.key?(button_name)
      button = CapybaraHelper::BUTTON_MAP[button_name]
      expect(page).to have_css("##{button}", text: button_name.to_s)
    elsif CapybaraHelper::FORM_BUTTON_MAP.key?(button_name)
      button = CapybaraHelper::FORM_BUTTON_MAP[button_name]
      name = find(:xpath, "//*[@id=\"#{button}\"]")['value']
      expect(name).to be == button_name.to_s
    else
      pending
    end
  end
end

And(/^I should see a "([^"]*)" button$/) do |button_name|
  expect(page).to have_content(button_name)
end
