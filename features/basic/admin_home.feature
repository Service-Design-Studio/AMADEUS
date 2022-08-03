@admin @admin_home
Feature: navigate to different admin functionalities
  As an admin of AMADEUS
  So that I can set tag as well as upload and edit articles
  I want to be able to easily navigate to them from my home page

  Background:
    Given I am logged in as an admin of AMADEUS
    Then I should see the following buttons: "Home, Category Bank, New Upload, Database"

  @redirect
  Scenario Outline: redirect to different functionalities
    When I click on the "<feature_name>" button
    Then I should be redirected to the "<feature_name>" page

    Examples:
      | feature_name  |
      | Home          |
      | Category Bank |
      | New Upload    |
      | Database      |