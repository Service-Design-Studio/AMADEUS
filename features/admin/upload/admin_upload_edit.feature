@admin @upload_edit
Feature: edit uploaded articles
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can make sure the articles are reliable and relevant
  I want to be able to modify their associated topics or delete them

  Background:
    Given I am logged in as admin of Amadeus
    And I have uploaded these zip files rus.zip, uav.zip, ukr.zip

  @redirect
  Scenario Outline: View Edit Upload page
    Given I am on the "Database" page
    When I click edit article "<article_name>"
    Then I should be redirected to the article "<article_name>" page
    And I should see the following buttons "Add new Topic, Delete this Upload, Back to Database"
    And I should see the following topics "<topics>"

    Examples:
      | article_name                                                                  | topics                                     |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf         | economy, noise, register, russia, sanction |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf | day, drug, fogel, russia, star             |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf   | city, plant, russia, severodonetsk, war    |

  @happy
  Scenario Outline: Delete topic
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I click delete button for the topic "<topic_name>"
    Then I should not see the topic "<topic_name>"

    Examples:
      | topic_name |
      | economy    |
      | noise      |
      | register   |
      | russia     |
      | sanction   |

  @happy
  Scenario Outline: Add new nonidentical topic
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the topic "<topic_name>"
    And I click on the "Add new Topic" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see the topic "<topic_name>"

    Examples:
      | topic_name  |
      | UAVs        |
      | Helicopters |
      | Tanks       |
      | Missiles    |
      | Artillery   |

  @sad
  Scenario Outline: Add duplicate topic
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the topic "<topic_name>"
    And I click on the "Add new Topic" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see a warning message "<topic_name> already exists!"

    Examples:
      | topic_name |
      | economy    |
      | noise      |
      | register   |
      | russia     |
      | sanction   |

  @sad
  Scenario: Add blank topic
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the topic ""
    And I click on the "Add new Topic" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see a warning message "Invalid topic input!"

  @sad
  Scenario Outline: Add topic that is more than 15 characters
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the topic "<topic_name>"
    And I click on the "Add new Topic" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see a warning message "Topic name too long!"

    Examples:
      | topic_name                 |
      | R o y L e e K a W e i      |
      | O k a K u r n i a w a n    |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZ |

  @sad
  Scenario Outline: Add ambiguous topic
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the topic "<topic_name>"
    And I click on the "Add new Topic" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see a warning message "Topic <topic_name> contains special characters!"

    Examples:
      | topic_name  |
      | $$$         |
      | Oka Kun     |
      | ( ͡❛ ͜ʖ ͡❛) |


  @redirect
  Scenario Outline: Edit topic
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I click on the topic "<topic_name>"
    Then I should be redirected to the "<topic_name>" edit page

    Examples:
      | topic_name |
      | economy    |
      | noise      |
      | register   |
      | russia     |
      | sanction   |

  @redirect
  Scenario: Back to home
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I click on the "Back to Upload Database" button
    Then I should be redirected to the "Home" page
