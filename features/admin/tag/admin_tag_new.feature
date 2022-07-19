@admin @tag_new
Feature: Add new Tag
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can include important tags that the AI might miss
  I want to be able to add in new tag

  Background:
    Given I am logged in as admin of Amadeus
    And I the following tags have been created "Tanks Artillery UAVs Helicopters Missiles MANPADs"

  Scenario: View New Tag page
    Given I am on the "Tag List" page
    When I click on the "New Tag" button
    Then I should be redirected to the "New Tag" page
    And I should see the following buttons "Save, Back to Tag List"

  @happy
  Scenario Outline: Add new nonidentical tag
    Given I am on the "New Tag" page
    When I add the tag "<tag_name>"
    And I click on the "Save" button
    Then I should be redirected to the "Tag List" page
    And I should see the tag "<tag_name>"

    Examples:
      | tag_name |
      | economy    |
      | noise      |
      | register   |
      | russia     |
      | sanction   |

  @sad
  Scenario Outline: Add duplicate tag
    Given I am on the "New Tag" page
    When I add the tag "<tag_name>"
    And I click on the "Save" button
    Then I should see a warning message "<tag_name> already exists!"

    Examples:
      | tag_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @sad
  Scenario: Add blank tag
    Given I am on the "New Tag" page
    When I add the tag ""
    And I click on the "Save" button
    Then I should see a warning message "Invalid tag input!"

  @sad
  Scenario Outline: Add tag that is more than 15 characters
    Given I am on the "New Tag" page
    When I add the tag "<tag_name>"
    And I click on the "Save" button
    Then I should see a warning message "Tag name too long!"

    Examples:
      | tag_name                 |
      | R o y L e e K a W e i      |
      | O k a K u r n i a w a n    |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZ |

  @sad
  Scenario Outline: Add ambiguous tag
    Given I am on the "New Tag" page
    When I add the tag "<tag_name>"
    And I click on the "Save" button
    And I should see a warning message "Tag <tag_name> contains special characters!"

    Examples:
      | tag_name  |
      | $$$         |
      | Oka Kun     |
      | ( ͡❛ ͜ʖ ͡❛) |

  @redirect
  Scenario: Back to Tag List
    Given I am on the "New Tag" page
    When I click on the "Back to Tag List" button
    Then I should be redirected to the "Tag List" page










