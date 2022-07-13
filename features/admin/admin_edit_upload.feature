@admin @upload @topics
Feature: edit uploaded articles
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can see the breakdown of category for this particular issue
  I want to see the list of topics belong to this issue

  Background:
    Given I am logged in as admin of Amadeus
    And I am viewing the upload database for the Russian-Ukraine war
    And I have uploaded these zip files into my database
      | zip_name |
      | rus.zip  |
      | uav.zip  |
      | ukr.zip  |

  @admin @topics
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

