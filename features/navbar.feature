@navbar
Feature: navigation bar
  As a general user of Amadeus
  So that I can find different the features of Amadeus
  I want to locate and access them easily

  Background:
    Given I just open Amadeus

  @view @user
  Scenario: navigating around Amadeus as regular user
    When I click the hamburger icon
    And I should see the following features Home, Admin

  @view @admin
  Scenario: navigating around Amadeus as admin
    Given I am logged in as admin of Amadeus
    When I click the hamburger icon
    And I should see the following features Home, Admin, Actions, Sign Out

  @user
  Scenario Outline: choosing features as regular user
    Given the navigation bar is open
    When I click on the <feature_name> feature
    Then I am redirected to the <feature_name> page

    Examples:
      | feature_name |
      |    Home      |
      |    Admin     |

  @admin
  Scenario Outline: choosing features as admin
    Given the navigation bar is open
    When I click on the <feature_name> feature
    Then I am redirected to the <feature_name> page

    Examples:
      | feature_name |
      |    Home      |
      |    Admin     |
      |   Sign Out   |

  @admin
  Scenario Outline: choosing sub-features as admin
    Given the navigation bar is open
    When I click on the Actions feature
    Then I click on the <feature_name> feature
    Then I am redirected to the <feature_name> page

    Examples:
      |    feature_name    |
      |     Topic List     |
      |     New Upload     |
      |   Upload Database  |