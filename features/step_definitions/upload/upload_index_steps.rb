When(/^I click edit article "([^"]*)"$/) do |article_name|
  expect(page).to have_content(article_name)
  case article_name
  when "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    find("#upload-1").click
    expect(page).to have_current_path("/admin/uploads/1/edit")
  when "Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf"
    find("#upload-2").click
    expect(page).to have_current_path("/admin/uploads/2/edit")
  when "uav-Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News.pdf"
    find("#upload-3").click
    expect(page).to have_current_path("/admin/uploads/3/edit")
  when "uav-Combat drones_ We are in a new era of warfare - here's why - BBC News.pdf"
    find("#upload-4").click
    expect(page).to have_current_path("/admin/uploads/4/edit")
  when "How many Ukrainian refugees are there and where have they gone_ - BBC News.pdff"
    find("#upload-5").click
    expect(page).to have_current_path("/admin/uploads/5/edit")
  when "Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf"
    find("#upload-6").click
    expect(page).to have_current_path("/admin/uploads/6/edit")
  end
end

Then(/^I should be redirected to the article "([^"]*)" page$/) do |article_name|
  case article_name
  when "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    expect(page).to have_current_path("/admin/uploads/1/edit")
  when "Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf"
    expect(page).to have_current_path("/admin/uploads/2/edit")
  when "uav-Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News.pdf"
    expect(page).to have_current_path("/admin/uploads/3/edit")
  when "uav-Combat drones_ We are in a new era of warfare - here's why - BBC News.pdf"
    expect(page).to have_current_path("/admin/uploads/4/edit")
  when "How many Ukrainian refugees are there and where have they gone_ - BBC News.pdff"
    expect(page).to have_current_path("/admin/uploads/5/edit")
  when "Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf"
    expect(page).to have_current_path("/admin/uploads/6/edit")
  end
end

