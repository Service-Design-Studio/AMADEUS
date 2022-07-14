@admin @upload
Feature: upload zipped folder containing pdf file of articles
  As an admin of Amadeus
  So that I can contribute documents for Amadeus's knowledge repository
  I want to upload pdf locally in bulk using zipped format

  Background:
    Given I am logged in as admin of Amadeus
    And I am on the "Upload" page
    And I should see an area to upload my zip files either by browsing or dragging
    And I should see a "Upload" button

  @success
  Scenario Outline: uploading zip file
    When I attach a zip file called <zip_name>
    Then I click on the "Upload" button
    And I should be redirected to the "Database" page
    And I should see a file called <file_name>

    Examples:
      | zip_name |                               file_name                                       |
      | rus.zip  | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf |
      | uav.zip  | Combat drones_ We are in a new era of warfare - here's why - BBC News.pdf     |
      | ukr.zip  | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf   |

  @fail
  Scenario: uploading zip file by manually adding files
    When I attach no zip file and upload
    And I should stay on the "Upload" page

  @redirect
  Scenario: want to leave upload page
    When I click on the "Back to Upload Database" button
    Then I should be redirected to the "Home" page
