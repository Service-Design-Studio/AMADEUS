And(/^I the following topics have been created "Tanks Artillery UAVs Helicopters Missiles MANPADs"$/) do
  setup
end

When(/^I am on the "([^"]*)" edit page$/) do |topic_name|
  visit("/admin/topics/#{topic_name.downcase}/edit")
  expect(page).to have_current_path("/admin/topics/#{topic_name.downcase}/edit")
end

When(/^I edit the topic into "([^"]*)"$/) do |topic_name|
  find("#topic-input").set(topic_name)
end

