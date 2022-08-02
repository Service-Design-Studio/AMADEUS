@sign_in
Feature: signing in as an admin
  As an admin of AMADEUS
  So that I can contribute documents for AMADEUS's knowledge repository
  I want to upload pdf locally in bulk using zipped format

  Background: View Sign In page
    Given I am on the "Sign In" page
    Then I should see a "Sign In" form with the following fields "Email", "Password"
    And I should see a "Sign In" button

  @happy
  Scenario Outline: Login with correct credentials
    Given I am on the "Sign In" page
    When I fill in my credentials with Email <email> and Password <password>
    And I click on the "Sign In" button
    Then I should be redirected to the "Admin" page

    Examples:
      | email              | password |
      | admin123@admin.com | admin123 |
      | admin456@admin.com | admin456 |
      | admin789@admin.com | admin789 |

  @sad
  Scenario Outline: Unable to login with incorrect credentials
    When I fill in my credentials with Email <email> and Password <password>
    And I click on the "Sign In" button
    Then I should stay on the "Sign In" page

    Examples:
      | email | password |
      | admin |          |
      |       | admin    |
      |       |          |
      | abcde | abcde    |