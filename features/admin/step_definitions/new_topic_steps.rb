Given(/^I am logged in as an admin of Amadeus and on topic list page$/) do
    capybara_login('admin123@admin.com', 'admin123')
    visit '/admin/topics'  
    expect(page).to have_current_path('/admin/topics')
end

Then(/^I should a list of topics$/) do
    expect(page).to have_content("cannabis")
    expect(page).to have_content("war")
    expect(page).to have_content("sanction")
    expect(page).to have_content("russia")
    expect(page).to have_content("economy")
    expect(page).to have_content("register")
    expect(page).to have_content("noise")
    expect(page).to have_content("basketball")
end

When(/^I click on New Topic button$/) do
    find("#new-topic-button").click
end

Then(/^I should be redirected to the new topic page$/) do
    expect(page).to have_current_path('/admin/topics/new')
end

When(/^I fill in the new topic form$/) do
    fill_in 'Name', with: 'testing123'
end

Then(/^I should be redirected to the topic list page, and see message of topic added.$/) do
    expect(page).to have_current_path('/admin/topics')
    expect(page).to have_content("testing123")
    expectg(page).to have_content("testing123 added.")
end

When(/^I fill in the new topic form with topic containing leading or trailing space$/) do |topic|
    fill_in 'Name', with: ' spaceinfront'
    fill_in 'Name', with: 'spacebehind '
end

Then(/^I should see an error message of Topic #{name} starts or ends with a space$/) do
    expect(page).to have_content("Topic spaceinfront starts or ends with a space.")
    expect(page).to have_content("Topic spacebehind starts or ends with a space.")
end

When(/^I fill in the new topic form with topic containing special characters$/) do |topic|
    fill_in 'Name', with: 'specialcharacters**'
    fill_in 'Name', with: 'special__characters'
end

Then(/^I should see an error message of Topic #{name} contains special characters$/) do
    expect(page).to have_content("Topic specialcharacters** contains special characters.")
    expect(page).to have_content("Topic special__characters contains special characters.")
end

When(/^I fill in the new topic form with topic containing spaces in between words$/) do
    fill_in 'Name', with: 'spaces in between words'
end

Then(/^I should be redirected to the topic list page, with message saying topic is added. and topic appearing in the list of topics $/) do
    expect(page).to have_current_path('/admin/topics')
    expect(page).to have_content("spaces in between words")
    expect(page).to have_content("spaces in between words added.")
end