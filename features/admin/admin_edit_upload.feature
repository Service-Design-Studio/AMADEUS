@admin @upload
Feature: admin edit uploaded file
  As an admin of Amadeus, I want to be able to edit uploaded files

  Background:
    Given I am logged in as admin of Amadeus
    And I am viewing the upload database page
    And I have these zip files already uploaded
      | zip_name | topic_name |
      | rus.zip  |   Russia   |
      | uav.zip  |    UAV     |
      | ukr.zip  |  Ukraine   |

  Scenario: View edit upload page
    Then I should see options for me to set topics, upload and edit articles
  
  Scenario: Click on topic
    Given I click on any topic
    Then I should be sent to Editing Topic page
  
  Scenario: Delete topic
    Given I click on any cross button
    Then Topic should be deleted
    And flash message should be shown

  Scenario: Add new topic
    Given the "Add new topic" field is filled
    And I click "Add new topic"
    Then topic is added

  Scenario: Trying to add empty topic name
    Given the "Add new topic" field is empty
    And I click "Add new topic"
    Then "Invalid topic input!" is shown
    
  Scenario: Want to leave edit upload page
    When I click "Back to Database" button
    Then I am redirected back to upload database page

