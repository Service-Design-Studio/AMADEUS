@user @categoriser_user
Feature: Browse articles according to their category
  As a user of Amadeus
  So that I can easily learn about a new topic
  I want to be able to read articles that are grouped by category

  Background:
    Given I am a user of Amadeus
    And the following categories have been created: "Tanks, Artillery, UAVs, Helicopters, Missiles, MANPADs, Fighter Aircraft, Infrastructure Strike"
    And the following zip files have been uploaded: rus.zip, uav.zip, ukr.zip

  Scenario: Viewing all articles when select no categories
    Given I am on the "Home" page
    Then I should see a sidebar with the following categories: "Tanks, Artillery, UAVs, Helicopters, Missiles, MANPADs, Fighter Aircraft, Infrastructure Strike"
    And I should see the following articles:
      | article_name                                                               |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News          |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News  |
      | Combat drones_ We are in a new era of warfare - here's why - BBC News      |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News  |
      | How many Ukrainian refugees are there and where have they gone_ - BBC News |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News    |

  @happy
  Scenario: Viewing category with linked articles
    Given I am on the "Home" page
    When I click on the category "UAVs"
    Then I should see the following articles:
      | article_name                                                              |
      | Combat drones_ We are in a new era of warfare - here's why - BBC News     |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News |

  @sad
  Scenario Outline: Viewing category with no linked articles
    Given I am on the "Home" page
    When I click on the category "<category_name>"
    Then I should see no articles
    And I should see a message "No articles at the moment. Sorry for the inconvenience."

    Examples:
      | category_name |
      | Tanks         |
      | Helicopters   |
      | Missiles      |
      | MANPADs       |
