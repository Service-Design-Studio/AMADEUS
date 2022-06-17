@admin
Feature: upload zipped folder containing pdf file of articles
  As an admin of Amadeus
  So that I can contribute documents for Amadeus's knowledge repository
  I want to upload pdf locally in bulk using zipped format

  Background:
    Given I am logged in as admin of Amadeus
    And I am trying to upload articles from the upload page

  @upload @view
  Scenario: view upload page
    Then I should see a "Browse" button
    And I should see a "Upload" button
    And I should see a "Article Count" field
    And I should see a warning text "Only zipped folder containing native (not scanned) pdf files is supported!"

  @upload @success
  Scenario Outline: (SUCCESS) upload valid zipped folder with pdf files
    When I click "Browse" button to select the "<folder_name>.zip" zipped folder
    And I click "Upload" button
    Then I should see a flash message "Successful"
    And I should see my article count increase by <count_value> inside the "Article Count" field

    Examples:
      | folder_name  | count_value |
      | valid_zip_1  |      1      |
      | valid_zip_5  |      5      |
      | valid_zip_10 |      10     |