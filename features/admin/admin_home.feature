@admin @home
Feature: navigate to different admin functionalities
  As an admin of Amadeus
  So that I can set topic, upload and edit articles
  I want to be able to easily navigate to them from my home page

  Background:
    Given I am logged in as admin of Amadeus

  @admin @view
  Scenario: view admin homepage
    Then I should see options for me to set topics, upload and edit articles

  @admin @success
  Scenario Outline: redirect to different functionalities
    When I select feature <feature_name>
    Then I should be redirected to <feature_name> page

    Examples:
    |  feature_name   |
    |  Topic List     |
    |   New Upload    |
    |  Edit articles  |