@admin @upload_edit
Feature: edit uploaded articles
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can make sure the articles are reliable and relevant
  I want to be able to modify their associated tags or delete them

  Background:
    Given I am logged in as an admin of Amadeus
    And I have uploaded these zip files: rus.zip, uav.zip, ukr.zip

  @redirect
  Scenario: View Edit Upload page
    Given I am on the "Database" page
    When I click edit article "<article_name>"
    Then I should be redirected to the article "<article_name>" edit page
    And I should see the following buttons: "Add new Tag, Delete this Upload, Back to Database"

  @redirect
  Scenario: Back to home
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I click on the "Back to Database" button
    Then I should be redirected to the "Database" page
