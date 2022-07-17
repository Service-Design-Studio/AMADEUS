@admin @topic_new
Feature: Add new Topic
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can include important topics that the AI might miss
  I want to be able to add in new topic

  Background:
    Given I am logged in as admin of Amadeus
    And I the following topics have been created "Tanks Artillery UAVs Helicopters Missiles MANPADs"

  Scenario: View New Topic page
    Given I am on the "Topic List" page
    When I click on the "New Topic" button
    Then I should be redirected to the "New Topic" page
    And I should see the following buttons "Save, Back to Topic List"

  @happy
  Scenario Outline: Add new nonidentical topic
    Given I am on the "New Topic" page
    When I add the topic "<topic_name>"
    And I click on the "Save" button
    Then I should be redirected to the "Topic List" page
    And I should see the topic "<topic_name>"

    Examples:
      | topic_name |
      | economy    |
      | noise      |
      | register   |
      | russia     |
      | sanction   |

  @sad
  Scenario Outline: Add duplicate topic
    Given I am on the "New Topic" page
    When I add the topic "<topic_name>"
    And I click on the "Save" button
    Then I should see a warning message "<topic_name> already exists!"

    Examples:
      | topic_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @sad
  Scenario: Add blank topic
    Given I am on the "New Topic" page
    When I add the topic ""
    And I click on the "Save" button
    Then I should see a warning message "Invalid topic input!"

  @sad
  Scenario Outline: Add topic that is more than 15 characters
    Given I am on the "New Topic" page
    When I add the topic "<topic_name>"
    And I click on the "Save" button
    Then I should see a warning message "Topic name too long!"

    Examples:
      | topic_name                 |
      | R o y L e e K a W e i      |
      | O k a K u r n i a w a n    |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZ |

  @sad
  Scenario Outline: Add ambiguous topic
    Given I am on the "New Topic" page
    When I add the topic "<topic_name>"
    And I click on the "Save" button
    And I should see a warning message "Topic <topic_name> contains special characters!"

    Examples:
      | topic_name  |
      | $$$         |
      | Oka Kun     |
      | ( ͡❛ ͜ʖ ͡❛) |

  @redirect
  Scenario: Back to Topic List
    Given I am on the "New Topic" page
    When I click on the "Back to Topic List" button
    Then I should be redirected to the "Topic List" page










