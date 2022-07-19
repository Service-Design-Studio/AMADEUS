@admin @tag_edit
Feature: Edit existing Tag
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can make sure the tag name is grammatically correct and meaningful
  I want to be able to edit the tag name

  Background:
    Given I am logged in as admin of Amadeus
    And I the following tags have been created "Tanks Artillery UAVs Helicopters Missiles MANPADs"

  Scenario Outline: View Edit Tag page
    Given I am on the "Tag List" page
    When I click on the tag "<tag_name>"
    Then I should be redirected to the "<tag_name>" edit page
    And I should see the following buttons "Save, Delete, Return"

    Examples:
      | tag_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @happy
  Scenario Outline: Delete tag
    Given I am on the "<tag_name>" edit page
    When I click on the "Delete" button
    Then I should be redirected to the "Tag List" page
    And I should not see the tag "<tag_name>"
    And I should see a warning message "Deleted <tag_name>"

    Examples:
      | tag_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @happy
  Scenario Outline: Edit into new nonidentical tag
    Given I am on the "UAVs" edit page
    When I edit the tag into "<tag_name>"
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
  Scenario Outline: Edit into duplicate tag
    Given I am on the "UAVs" edit page
    When I edit the tag into "<tag_name>"
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
  Scenario Outline: Edit into blank tag
    Given I am on the "<tag_name>" edit page
    When I edit the tag into ""
    And I click on the "Save" button
    Then I should see a warning message "Invalid tag input!"

    Examples:
      | tag_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @sad
  Scenario Outline: Edit into tag that is more than 15 characters
    Given I am on the "UAVs" edit page
    When I edit the tag into "<tag_name>"
    And I click on the "Save" button
    Then I should see a warning message "Tag name too long!"

    Examples:
      | tag_name                 |
      | R o y L e e K a W e i      |
      | O k a K u r n i a w a n    |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZ |

  @sad
  Scenario Outline: Edit into ambiguous tag
    Given I am on the "UAVs" edit page
    When I edit the tag into "<tag_name>"
    And I click on the "Save" button
    And I should see a warning message "Tag <tag_name> contains special characters!"

    Examples:
      | tag_name  |
      | $$$         |
      | Oka Kun     |
      | ( ͡❛ ͜ʖ ͡❛) |

  @redirect
  Scenario Outline: Back to Tag List page
    Given I am on the "Tag List" page
    And I click on the tag "<tag_name>"
    Then I should be redirected to the "<tag_name>" edit page
    When I click on the "Return" button
    Then I should be redirected to the "Tag List" page

    Examples:
      | tag_name  |
      | Tanks       |
      | UAVs        |
      | Helicopters |
      | Missiles    |
      | MANPADs     |

  @redirect
  Scenario Outline: Back to article page
    Given I have uploaded these zip files rus.zip, uav.zip, ukr.zip
    And I am on the article "<article_name>" page
    And I click on the tag "<tag_name>"
    Then I should be redirected to the "<tag_name>" edit page
    When I click on the "Return" button
    Then I should be redirected to the article "<article_name>" page

    Examples:
      | article_name                                                                  | tag_name |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf         | economy    |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf | russia     |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf   | war        |










