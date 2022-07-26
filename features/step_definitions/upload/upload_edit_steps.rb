Given(/^I am on the article "([^"]*)" edit page$/) do |article_name|
  steps %Q{
    Given I am on the "Database" page
    When I click edit article "#{article_name}"
    Then I should be redirected to the article "#{article_name}" edit page
  }
end
