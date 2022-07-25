@admin @upload_edit
Feature: edit uploaded articles
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can make sure the articles are reliable and relevant
  I want to be able to modify their associated tags or delete them

  Background:
    Given I am logged in as admin of Amadeus
    And I have uploaded these zip files rus.zip, uav.zip, ukr.zip

  @redirect
  Scenario Outline: View Edit Upload page
    Given I am on the "Database" page
    When I click edit article "<article_name>"
    Then I should be redirected to the article "<article_name>" page
    And I should see the following buttons "Add new Tag, Delete this Upload, Back to Database"
    And I should see the following tags "<tags>"

    Examples:
      | article_name                                                                  | tags                                        |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf         | economy, noise, cut, russia, register       |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf | basketball, drug, fogel, russia, star       |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf   | azot, plant, russia, severodonetsk, control |

  @happy
  Scenario Outline: Delete tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I click delete button for the tag "<tag_name>"
    Then I should not see the tag "<tag_name>"

    Examples:
      | tag_name |
      | economy  |
      | noise    |
      | register |
      | russia   |
      | cut      |

  @happy
  Scenario Outline: Add new nonidentical tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the tag "<tag_name>"
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see the tag "<tag_name>"

    Examples:
      | tag_name    |
      | UAVs        |
      | Helicopters |
      | Tanks       |
      | Missiles    |
      | Artillery   |

  @sad
  Scenario Outline: Add duplicate tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the tag "<tag_name>"
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see a warning message "<tag_name> already exists!"

    Examples:
      | tag_name |
      | noise    |
      | register |
      | russia   |
      | cut      |

  @sad
  Scenario: Add blank tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the tag ""
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see a warning message "Invalid tag input!"

  @sad
  Scenario Outline: Add tag that is more than 15 characters
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the tag "<tag_name>"
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see a warning message "Tag name too long!"

    Examples:
      | tag_name                   |
      | R o y L e e K a W e i      |
      | O k a K u r n i a w a n    |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZ |

  @sad
  Scenario Outline: Add ambiguous tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I add the tag "<tag_name>"
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf"
    And I should see a warning message "Tag <tag_name> contains special characters!"

    Examples:
      | tag_name    |
      | $$$         |
      | Oka Kun     |
      | ( ͡❛ ͜ʖ ͡❛) |

  @redirect
  Scenario: Back to home
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf" page
    When I click on the "Back to Database" button
    Then I should be redirected to the "Database" page
