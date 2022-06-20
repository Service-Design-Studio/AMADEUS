And(/^I should see a "([^"]*)" button$/) do |button_name|
  page.should have_content(button_name)
end