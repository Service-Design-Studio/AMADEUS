@sign_in
Feature: signing in as an admin
  As an admin of Amadeus
  So that I can contribute documents for Amadeus's knowledge repository
  I want to upload pdf locally in bulk using zipped format

  Background:
    Given I want to log in as an admin of Amadeus


  @sign_in @view
  Scenario: view sign in page
    Then I should see a "Sign In" form that requires email and password credentials


  @sign_in @success
  Scenario Outline: (Success) able to log in with the correct credentials
    When I sign in with correct credentials Email <email> and password <password>

    Examples:
      |       email        |  password   |
      | admin123@admin.com |  admin123   |
      | admin456@admin.com |  admin456   |
      | admin789@admin.com |  admin789   |

  @sign_in @fail
  Scenario Outline: (Fail) unable to log in with incorrect credentials
    When I fill in my credentials with Email <email> and Password <password>
    And I click on the "Sign in" button
    Then I should stay on the login page

    Examples:
      | email | password |
      | admin |          |
      |       |   admin  |
      |       |          |
      | abcde |  abcde   |