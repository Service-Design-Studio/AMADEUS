Given (/^I am logged in as an admin of Amadeus and on topic list page$/) do
    capybara_login('admin123@admin.com', 'admin123')
    visit '/admin/topics'
    expect(page).to have_current_path('/admin/topics')
end

Then(/^I should a list of topics, that I can click into to edit$/) do
    expect(page).to have_content("cannabis")
    expect(page).to have_content("war")
    expect(page).to have_content("sanction")
    expect(page).to have_content("russia")
    expect(page).to have_content("economy")
    expect(page).to have_content("register")
    expect(page).to have_content("noise")
    expect(page).to have_content("basketball")
end

When(/^I click on a topic$/) do |topic|
    if topic == "cannabis"
        find("#cannabis").click
    elsif topic == "war"
        find("#war").click
    elsif topic == "sanction"
        find("#sanction").click
    elsif topic == "russia"
        find("#russia").click
    elsif topic == "economy"
        find("#economy").click
    elsif topic == "register"
        find("#register").click
    elsif topic == "noise"
        find("#noise").click
    elsif topic == "basketball"
        find("#basketball").click
    end
end

Then (/^I should be redirected to the edit topic page$/) do |topic|
    #or use topic[:id] not sure
    if topic == "cannabis"
        expect(page).to have_current_path('/admin/topics/14/edit')
    elsif topic == "war"
        expect(page).to have_current_path('/admin/topics/12/edit')
    elsif topic == "sanction"
        expect(page).to have_current_path('/admin/topics/11/edit')
    elsif topic == "russia"
        expect(page).to have_current_path('/admin/topics/10/edit')
    elsif topic == "economy"
        expect(page).to have_current_path('/admin/topics/7/edit')
    elsif topic == "register"
        expect(page).to have_current_path('/admin/topics/9/edit')
    elsif topic == "noise"
        expect(page).to have_current_path('/admin/topics/8/edit')
    elsif topic == "basketball"
        expect(page).to have_current_path('/admin/topics/13/edit')
    end
end

When(/^I click on the delete button$/) do |topic|
    if topic == "cannabis"
        find("#cannabis-delete").click
    elsif topic == "war"
        find("#war-delete").click
    elsif topic == "sanction"
        find("#sanction-delete").click
    elsif topic == "russia"
        find("#russia-delete").click
    elsif topic == "economy"
        find("#economy-delete").click
    elsif topic == "register"
        find("#register-delete").click
    elsif topic == "noise"
        find("#noise-delete").click
    elsif topic == "basketball"
        find("#basketball-delete").click
    end
end

Then(/^I should be redirected to the topic list page$/) do
    expect(page).to have_current_path('/admin/topics')
end

When(/^I click on the Back to Topic List button$/) do
    find("#back-to-topic-list").click
end

Then(/^I should be redirected to the topic list page$/) do
    expect(page).to have_current_path('/admin/topics')
end

When(/^I edit the topic into an existing one$/) do
    find("#cannabis-edit").click
    fill_in "topic_name", with: "basketball"
    click_button "save"
end

Then(/^I should see a message that the topic already exists$/) do
    expect(page).to have_content("Name has already been taken")
end

When(/^I edit the topic into a new one$/) do
    find("#cannabis-edit").click
    fill_in "topic_name", with: "Madness"
    click_button "save"
end

Then(/^I should be redirected to topic list page and see a message that the topic has been updated$/) do
    expect(page).to have_current_path('/admin/topics')
    expect(page).to have_content("cannabis updated into Madness.")
end

When(/^I edit the topic into one with characters not allowd (eg trailing spaces special characters)$/) do
    find("#cannabis-edit").click
    fill_in "topic_name", with: "   test "
    click_button "save"
end

Then(/^I should see a message that the Name can't be blank and Name is invalid$/) do
    expect(page).to have_content("Name is invalid")
    expect(page).to have_content("Name can't be blank")
end

Then('flash message shwon as {string}') do |string|
    expect(page).to have_content(string)
end

  
Then('I should return to the topic list page') do
    expect(page).to have_current_path('/admin/topics')
end