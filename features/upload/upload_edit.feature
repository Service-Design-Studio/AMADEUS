@admin @upload_edit
Feature: edit uploaded articles
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can make sure the articles are reliable and relevant
  I want to be able to modify their associated tags or delete them

  Background:
    Given I am logged in as an admin of Amadeus
    And I have uploaded these zip files: rus.zip, uav.zip, ukr.zip

  @redirect
  Scenario Outline: View Edit Upload page
    Given I am on the "Database" page
    When I click edit article "<article_name>"
    Then I should be redirected to the article "<article_name>" edit page
    And I should see the following buttons: "Add new Tag, Delete this Upload, Back to Database"

    Examples:
      | article_name                                                               |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News          |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News  |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News  |
      | Combat drones_ We are in a new era of warfare - here's why - BBC News      |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News    |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News |

  @redirect
  Scenario: Back to home
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I click on the "Back to Database" button
    Then I should be redirected to the "Database" page
