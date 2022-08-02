@admin @upload_index
Feature: uploaded zipped folder successfully
  As an admin of AMADEUS
  So that i know that I have uploaded my files successfully
  I want to be able to view all the zip files that i have uploaded

  Background:
    Given I am logged in as an admin of AMADEUS
    And I am on the "Database" page
    When I have uploaded these zip files: rus.zip, uav.zip, ukr.zip
    Then I should see the following articles:
      | article_name                                                               |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News          |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News  |
      | Combat drones_ We are in a new era of warfare - here's why - BBC News      |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News  |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News    |

  @redirect
  Scenario: Create new upload
    When I click on the "New Upload" button
    Then I should be redirected to the "Upload" page

  @redirect
  Scenario: Back to home
    When I click on the "Back to Home" button
    Then I should be redirected to the "Admin" page

  @redirect
  Scenario Outline: Navigate to Edit Upload page
    Given I am on the "Database" page
    When I click edit article "<article_name>"
    Then I should be redirected to the article "<article_name>" edit page

    Examples:
      | article_name                                                               |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News          |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News  |
      | Combat drones_ We are in a new era of warfare - here's why - BBC News      |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News  |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News    |
