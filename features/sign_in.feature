@admin
Feature: signing in as an admin
  As an admin of Amadeus
  So that I can contribute documents for Amadeus's knowledge repository
  I want to upload pdf locally in bulk using zipped format

  Background:
    Given I want to log in as an admin of Amadeus


  @sign_in @view
  Scenario: view sign in page after choosing admin path
    Then I should see a "Sign In" title
    And I should see a "Sign In" form that requires email and password credentials


  @sign_in @success
  Scenario Outline: (Success) able to log in with the correct credentials
    When I fill in my credentials with Email <email> and Password <password>
    And I click on the "Sign in" button
    Then I should be logged in as admin

    Examples:
      | email | password |
      | admin |  admin   |

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