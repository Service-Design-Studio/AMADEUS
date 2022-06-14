Feature: upload a pdf file
  As a admin of Amadeus
  So that I can contribute classified documents for Amadeus's knowledge repository
  I want to upload pdf locally

  Background: I am logged in as admin
    And I am on my phone
    And I am on the upload page

  Scenario: show files for browsing
    When I click upload button
    Then I should see a pop up window on my phone to select file for upload

  Scenario: select file
    When I click on a file after browsing
    Then I should be redirected back to the upload page
    And I should see my file is uploaded

  Scenario: submit file
    When I click submit button
    Then I should be redirected to result page
    And I should see the text output of my parsed pdf