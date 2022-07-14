@admin @upload @topics
Feature: edit uploaded articles
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can make sure the articles are reliable and relevant
  I want to be able to modify their associated topics or delete them

  Background:
    Given I am logged in as admin of Amadeus
    And I am viewing the upload database for the Russian-Ukraine war
    And I have uploaded these zip files into my database
      | zip_name |
      | rus.zip  |
      | uav.zip  |
      | ukr.zip  |

  @view
  Scenario Outline: View article under the topic of Russian-Ukraine war
    Then I should see options for me to set topics, upload and edit articles
    And I should see all the following articles <article>

    Examples:
      | article |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News.pdf  |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News.pdf          |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News.pdf    |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News.pdf |

  @view
  Scenario Outline: Click topic to view more information
    When I click on <topic> to understand more about the war
    Then I should be sent to Editing Topic page belongs to <topic>

    Examples:
      | topic |
      | UAVs  |
      | Tanks |
      | Artillery |

  @delete
  Scenario Outline: Delete unreliable topics
    When I want to remove the <topic> as I find it irrelevant
    And I press the cross next to the <topic>
    Then the <topic> should be deleted

    Examples:
      | topic |
      | Missles |
      | MANPADs |
      | Infrastructure damage/strike |

  @add
  Scenario: Add new topic
    Given the I want to add the following topics "Cyberwarfare", "Anonymour", "Elon Musk"
    When I click "Add new topic"
    Then I should be redirected to the Add topic page

  @add @fail
  Scenario: Trying to add empty topic name
    Given the "Add new topic" field is empty
    And I click "Add new topic"
    Then "Invalid topic input!" is shown

  @redirect
  Scenario: Want to leave edit upload page
    When I click "Back to Database" button
    Then I am redirected back to upload database page
