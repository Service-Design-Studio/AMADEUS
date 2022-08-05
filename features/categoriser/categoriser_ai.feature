@admin @categoriser_ai
Feature: AI automatically detect category
  As an admin of AMADEUS
  So that I can quickly organize uploaded articles
  I want to have my articles to be categorized by an AI when they are uploaded


  Background:
    Given I am logged in as an admin of AMADEUS
    And I have created the following categories: "Tanks, Artillery, UAVs, Helicopters, Missiles, MANPADs, Fighter Aircraft, Infrastructure Strike"

  @happy
  Scenario Outline: Auto-generated category after each upload
    Given I am on the "New Upload" page
    When I attach a zip file called <zip_name>
    And I click on the "Upload" button
    Then I should be redirected to the "Database" page
    And I should see an article called <article_name> with the category <category_name>
    And the category <category_name> should be from the following list of categories "Tanks, Artillery, UAVs, Helicopters, Missiles, MANPADs, Fighter Aircraft, Infrastructure Strike"

    Examples:
      | zip_name | article_name                                                   | category_name         |
      | rus.zip  | Russia's economy in for a bumpy ride as sanctions bite         | Infrastructure Strike |
      | rus.zip  | Russia sentences US teacher to 14 years for cannabis smuggling | Infrastructure Strike |
      | uav.zip  | Combat drones_ We are in a new era of warfare - here's why     | UAVs                  |
      | uav.zip  | Chinese drone firm DJI pauses operations in Russia and Ukraine | UAVs                  |
      | ukr.zip  | Ukraine war_ Thousands of civilians trapped in Severodonetsk   | Infrastructure Strike |
      | ukr.zip  | How many Ukrainian refugees are there and where have they gone | Infrastructure Strike |

  @happy
  Scenario Outline: Re-categorise into different category
    Given  I have deleted the following categories: "Infrastructure Strike, UAVs" from the list of categories
    And I have added the following categories: "War, Drones" to the list of categories
    And I am on the "New Upload" page
    When I attach a zip file called <zip_name>
    And I click on the "Upload" button
    Then I should be redirected to the "Database" page
    And I should see an article called <article_name> with the category <category_name>
    And the category <category_name> should be from the following list of categories "Tanks, Artillery, Drones, Helicopters, Missiles, MANPADs, Fighter Aircraft, War"

    Examples:
      | zip_name | article_name                                                   | category_name |
      | rus.zip  | Russia's economy in for a bumpy ride as sanctions bite         | War           |
      | rus.zip  | Russia sentences US teacher to 14 years for cannabis smuggling | Artillery     |
      | uav.zip  | Combat drones_ We are in a new era of warfare - here's why     | Drones        |
      | uav.zip  | Chinese drone firm DJI pauses operations in Russia and Ukraine | Drones        |
      | ukr.zip  | Ukraine war_ Thousands of civilians trapped in Severodonetsk   | War           |
      | ukr.zip  | How many Ukrainian refugees are there and where have they gone | War           |

  @sad
  Scenario Outline: No category in category Bank
    Given I have no category in Category Bank
    And I am on the "New Upload" page
    When I attach a zip file called <zip_name>
    And I click on the "Upload" button
    Then I should be redirected to the "Database" page
    And I should see an article called <article_name> with "No Category" label

    Examples:
      | zip_name | article_name                                                   |
      | rus.zip  | Russia's economy in for a bumpy ride as sanctions bite         |
      | rus.zip  | Russia sentences US teacher to 14 years for cannabis smuggling |
      | uav.zip  | Combat drones_ We are in a new era of warfare - here's why     |
      | uav.zip  | Chinese drone firm DJI pauses operations in Russia and Ukraine |
      | ukr.zip  | Ukraine war_ Thousands of civilians trapped in Severodonetsk   |
      | ukr.zip  | How many Ukrainian refugees are there and where have they gone |
