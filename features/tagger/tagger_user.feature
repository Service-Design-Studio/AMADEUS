@user @tagger_user
Feature: Explore related articles via tags
  As a user of Amadeus
  So that I can discover related articles
  I want to be able to explore other articles that have the same tags as the current one I'm reading

  Background:
    Given I am a user of Amadeus
    And the following zip files have been uploaded: rus.zip, uav.zip, ukr.zip

  @view
  Scenario Outline: Viewing article
    Given I am viewing the article "<article_name>"
    Then I should see the following tags: "<tags>"

    Examples:
      | article_name                                                               | tags                                        |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News          | economy, noise, cut, russia, sanction       |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News  | basketball, drug, fogel, russia, star       |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News  | dji, drone, product, russia, use            |
      | Combat drones_ We are in a new era of warfare - here's why - BBC News      | attack, drone, technology, use, warfare     |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News    | azot, plant, russia, severodonetsk, control |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News | kyiv, refugee, russia, ukraine, ukrainians  |

  @happy
  Scenario: Exploring a tag with linked articles
    Given I am viewing the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    When I click on the linking tag "russia"
    Then I should be redirected to the linking page for the tag "russia"
    And I should see the following suggested articles:
      | article_name                                                               |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News  |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News  |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News    |


  @happy
  Scenario Outline: Exploring a tag with no linked articles
    Given I am viewing the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    When I click on the linking tag "<tag_name>"
    Then I should be redirected to the linking page for the tag "<tag_name>"
    And I should see a message "No linked articles at the moment. Sorry for the inconvenience."
    Examples:
      | tag_name |
      | cut      |
      | economy  |
      | noise    |
      | sanction |
