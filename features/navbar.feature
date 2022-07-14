@navbar
Feature: navigation bar
  As a general user of Amadeus
  So that I can find different the features of Amadeus
  I want to locate and access them easily

  @view @user
  Scenario: navigating around Amadeus as regular user
    Given I am on the "Home" page
    When I click the hamburger icon
    And I should see the following buttons "Home, Admin"

  @view @admin
  Scenario: navigating around Amadeus as admin
    Given I am logged in as admin of Amadeus
    When I click the hamburger icon
    And I should see the following buttons "Home, Admin, Actions, Sign Out"

  @user @redirect
  Scenario: choosing features as regular user
    Given I am a regular user
    And the navigation bar is open
    When I click on the "Home" button
    Then I should be redirected to the "Home" page

  @user @redirect
  Scenario:
    Given I am a regular user
    And the navigation bar is open
    When I click on the "Admin" button
    Then I should be redirected to the "Sign In" page

  @admin @redirect
  Scenario Outline: choosing features as admin
    Given I am logged in as admin of Amadeus
    And the navigation bar is open
    When I click on the "<feature_name>" button
    Then I should be redirected to the "<feature_name>" page

    Examples:
      | feature_name |
      |    Home      |
      |    Admin     |
      |   Sign Out   |
