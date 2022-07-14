@sign_in
Feature: signing in as an admin
  As an admin of Amadeus
  So that I can contribute documents for Amadeus's knowledge repository
  I want to upload pdf locally in bulk using zipped format

  Background:
    Given I am on the "Sign In" page
    Then I should see a "Sign In" form with the following fields "Email", "Password"
    And I should see a "Sign In" button

  @success
  Scenario Outline: (Success) able to log in with the correct credentials
    When I fill in my credentials with Email <email> and Password <password>
    Then I should be redirected to the "Admin Home" page

    Examples:
      |       email        |  password   |
      | admin123@admin.com |  admin123   |
      | admin456@admin.com |  admin456   |
      | admin789@admin.com |  admin789   |

  @fail
  Scenario Outline: (Fail) unable to log in with incorrect credentials
    When I fill in my credentials with Email <email> and Password <password>
    And I click on the "Sign in" button
    Then I should stay on the "Sign In" page

    Examples:
      | email | password |
      | admin |          |
      |       |   admin  |
      |       |          |
      | abcde |  abcde   |