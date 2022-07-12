@admin @db
Feature: uploaded zipped folder successfully
  As an admin of Amadeus
  So that i know that I have uploaded my files successfully
  I want to be able to view all the zip files that i have uploaded
  Background:
    Given I am logged in as admin of Amadeus
    And I am viewing the upload database page
    And I have these zip files already uploaded
      | zip_name |
      | rus.zip  |
      | uav.zip  |
      | ukr.zip  |

  @db @view
  Scenario: viewing all the uploaded zip
    Then I should see all the uploaded zip files

  @db @upload
  Scenario: Want to upload more files
    When I click on the "New Upload" button
    Then I am redirected back to the upload page
