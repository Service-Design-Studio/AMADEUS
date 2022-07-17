@admin @topic_edit
Feature: Edit existing Topic
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can make sure the topic name is grammatically correct and meaningful
  I want to be able to edit the topic name

  Background:
    Given I am logged in as admin of Amadeus
    And I the following topics have been created "Tanks Artillery UAVs Helicopters Missiles MANPADs"

  Scenario Outline: View Edit Topic page
    Given I am on the "Topic List" page
    When I click on the topic "<topic_name>"
    Then I should be redirected to the "<topic_name>" edit page
    And I should see the following buttons "Save, Delete, Return"

    Examples:
      | topic_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @happy
  Scenario Outline: Delete topic
    Given I am on the "<topic_name>" edit page
    When I click on the "Delete" button
    Then I should be redirected to the "Topic List" page
    And I should not see the topic "<topic_name>"
    And I should see a warning message "Deleted <topic_name>"

    Examples:
      | topic_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @happy
  Scenario Outline: Edit into new nonidentical topic
    Given I am on the "UAVs" edit page
    When I edit the topic into "<topic_name>"
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
  Scenario Outline: Edit into duplicate topic
    Given I am on the "UAVs" edit page
    When I edit the topic into "<topic_name>"
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
  Scenario Outline: Edit into blank topic
    Given I am on the "<topic_name>" edit page
    When I edit the topic into ""
    And I click on the "Save" button
    Then I should see a warning message "Invalid topic input!"

    Examples:
      | topic_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @sad
  Scenario Outline: Edit into topic that is more than 15 characters
    Given I am on the "UAVs" edit page
    When I edit the topic into "<topic_name>"
    And I click on the "Save" button
    Then I should see a warning message "Topic name too long!"

    Examples:
      | topic_name                 |
      | R o y L e e K a W e i      |
      | O k a K u r n i a w a n    |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZ |

  @sad
  Scenario Outline: Edit into ambiguous topic
    Given I am on the "UAVs" edit page
    When I edit the topic into "<topic_name>"
    And I click on the "Save" button
    And I should see a warning message "Topic <topic_name> contains special characters!"

    Examples:
      | topic_name  |
      | $$$         |
      | Oka Kun     |
      | ( ͡❛ ͜ʖ ͡❛) |

  @redirect
  Scenario Outline: Back to Topic List page
    Given I am on the "Topic List" page
    And I click on the topic "<topic_name>"
    Then I should be redirected to the "<topic_name>" edit page
    When I click on the "Return" button
    Then I should be redirected to the "Topic List" page

    Examples:
      | topic_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @redirect
  Scenario Outline: Back to article page
    Given I have uploaded these zip files rus.zip, uav.zip, ukr.zip
    And I am on the article "<article_name>" page
    And I click on the topic "<topic_name>"
    Then I should be redirected to the "<topic_name>" edit page
    When I click on the "Return" button
    Then I should be redirected to the article "<article_name>" page

    Examples:
      | article_name                                                                  | topic_name |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf         | economy    |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf | russia     |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf   | war        |










