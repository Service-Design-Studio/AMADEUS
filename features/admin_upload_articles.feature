@admin @upload
Feature: upload zipped folder containing pdf file of articles
  As an admin of Amadeus
  So that I can contribute documents for Amadeus's knowledge repository
  I want to upload pdf locally in bulk using zipped format

  Background:
    Given I am logged in as admin of Amadeus
    And I am viewing the upload page

  @upload @view
  Scenario: view upload page
    Then I should see an area to input my Topic
    And I should see an area to upload my zip files either by browsing or dragging

  @upload @success
  Scenario Outline: uploading zip file
    When I attach a zip file called <zip_name> and key in the topic <topic_name>
    Then I click on the "Create Upload" button
    And I should be redirected to upload database
    And I should see the above <zip_name> zip file with its corresponding <topic_name>

    Examples:
      | zip_name | topic_name |
      | rus.zip  |   Russia   |
      | uav.zip  |    UAV     |
      | ukr.zip  |  Ukraine   |

  @upload @fail
  Scenario Outline: uploading zip file by manually adding files
    When I attach no zip file and key in the topic <topic_name>
    Then I click on the "Create Upload" button
    And I should remain in this upload page

    Examples:
      | topic_name |
      |   Russia   |
      |    UAV     |
      |  Ukraine   |

  @upload
  Scenario: want to leave upload page
    When I click "Back to Upload Database" button
    Then I am redirected back to upload database page
