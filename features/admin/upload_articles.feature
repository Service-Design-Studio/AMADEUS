@admin
Feature: upload zipped folder containing pdf file of articles
  As an admin of Amadeus
  So that I can contribute documents for Amadeus's knowledge repository
  I want to upload pdf locally in bulk using zipped format

  Background:
     Given I am trying to upload articles from the upload page as an admin of Amadeus

  # @upload @view
  # Scenario: view upload page
  #   Then I should see a form that allows me to upload zip folder
  #   And I should be able to set the corresponding topic
  #   And I should see a "Create Upload" button

  # @upload @success
  # Scenario Outline: (SUCCESS) upload valid zipped folder with pdf files
  #   When I click "Browse" button to select the "<folder_name>.zip" zipped folder
  #   And I click "Upload" button
  #   Then I should see a flash message "Successful"
  #   And I should see my article count increase by <count_value> inside the "Article Count" field

  #   Examples:
  #     | folder_name  | count_value |
  #     | valid_zip_1  |      1      |
  #     | valid_zip_5  |      5      |
  #     | valid_zip_10 |      10     |

  # @upload @fail
  # Scenario Outline: (FAIL) upload invalid zipped folder with no pdf files
  #   When I click "Browse" button to select the "<folder_name>.zip" zipped folder
  #   And I click "Upload" button
  #   Then I should see a flash message "<flash_content>"
  #   And I should see my article count unchanged inside the "Article Count" field

  #   Examples:
  #     | folder_name       | flash_content       |
  #     | invalid_zip_0     | Empty folder!       |
  #     | invalid_zip_other | No pdf files found! |