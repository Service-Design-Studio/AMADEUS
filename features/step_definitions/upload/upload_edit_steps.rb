Given(/^I am on the edit page for the article "([^"]*)"$/) do |article_name|
  steps %Q{
    Given I am on the "Database" page
    When I click edit article "#{article_name}"
    Then I should be redirected to the edit page for the article "#{article_name}"
  }
end
