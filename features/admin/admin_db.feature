@admin @db
Feature: uploaded zipped folder successfully
  As an admin of Amadeus
  So that i know that I have uploaded my files successfully
  I want to be able to view all the zip files that i have uploaded

  Background:
    Given I am logged in as admin of Amadeus
    And I am on the "Database" page
    And I have uploaded these zip files rus.zip, uav.zip, ukr.zip
    Then I should see the following files
      |                               file_name                                        |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf  |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf  |
      | Combat drones_ We are in a new era of warfare - here's why - BBC News.pdf      |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News.pdf  |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News.pdf |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf    |

  @redirect
  Scenario: Want to upload more files
    When I click on the "New Upload" button
    Then I should be redirected to the "Upload" page

  @redirect
  Scenario: Back to home
    When I click on the "Back to Home" button
    Then I should be redirected to the "Admin" page
