@admin @home
Feature: navigate to different admin functionalities
  As an admin of Amadeus
  So that I can set topic, upload and edit articles
  I want to be able to easily navigate to them from my home page

  Background:
    Given I am logged in as admin of Amadeus
    Then I should see the following buttons "Topic List, New Upload, Database"

  @admin @redirect
  Scenario Outline: redirect to different functionalities
    When I click on the "<feature_name>" button
    Then I should be redirected to the "<feature_name>" page

    Examples:
      | feature_name |
      | Topic List   |
      | New Upload   |
      | Database     |