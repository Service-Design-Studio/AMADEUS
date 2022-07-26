@admin @tagger_upload
Feature: Edit category linked to an article
  As an admin of Amadeus
  So that I can manage the tags that are currently linked to an article
  I want to be able to edit the tags in the article Edit page

  Background:
    Given I am logged in as an admin of Amadeus
    And I have uploaded these zip files: rus.zip, uav.zip, ukr.zip

  @redirect
  Scenario Outline: View Edit Upload page
    Given I am on the "Database" page
    When I click edit article "<article_name>"
    Then I should be redirected to the article "<article_name>" page
    And I should see the following buttons: "Add new Tag, Delete this Upload, Back to Database"
    And I should see the following tags: "<tags>"

    Examples:
      | article_name                                                               | tags                                        |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News          | economy, noise, cut, russia, sanction       |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News  | basketball, drug, fogel, russia, star       |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News  | dji, drone, product, russia, use            |
      | Combat drones_ We are in a new era of warfare - here's why - BBC News      | attack, drone, technology, use, warfare     |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News    | azot, plant, russia, severodonetsk, control |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News | kyiv, refugee, russia, ukraine, ukrainians  |


  @happy
  Scenario Outline: Delete tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I click delete button for the tag "<tag_name>"
    Then I should not see the tag "<tag_name>"

    Examples:
      | tag_name |
      | economy  |
      | noise    |
      | sanction |
      | russia   |
      | cut      |

  @happy
  Scenario Outline: Add new nonidentical tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I add the tag "<tag_name>"
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    And I should see the tag "<tag_name>"

    Examples:
      | tag_name     |
      | weapons      |
      | war          |
      | cyberthreats |
      | drone        |
      | attack       |

  @sad
  Scenario Outline: Add duplicate tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I add the tag "<tag_name>"
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    And I should see a warning message "<tag_name> already exists!"

    Examples:
      | tag_name |
      | noise    |
      | sanction |
      | russia   |
      | cut      |

  @sad
  Scenario: Add blank tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I add the tag ""
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    And I should see a warning message "Invalid tag input!"

  @sad
  Scenario Outline: Add tag that is more than 15 characters
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I add the tag "<tag_name>"
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    And I should see a warning message "Tag name is too long!"

    Examples:
      | tag_name                   |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZ |

  @sad
  Scenario Outline: Add ambiguous tag
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I add the tag "<tag_name>"
    And I click on the "Add new Tag" button
    Then I should still see the same article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    And I should see a warning message "Tag <tag_name> contains special characters!"

    Examples:
      | tag_name    |
      | $$$         |
      | Oka @@      |
      | ( ͡❛ ͜ʖ ͡❛) |