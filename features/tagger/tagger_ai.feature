@admin @tagger_ai
Feature: AI automatically detect tag
  As an admin of AMADEUS
  So that I can quickly understand what the article is about
  I want to have my articles to have a list of 5 tagged keywords by an AI when they are uploaded

  Background:
    Given I am logged in as an admin of AMADEUS

  @happy
  Scenario Outline: Auto-generated 5 keyword tags from the article after each upload
    Given I am on the "New Upload" page
    When I attach a zip file called rus.zip
    And I click on the "Upload" button
    Then I should be redirected to the "Database" page
    And I should see an article called <article_name> with 5 tags
    And I should see the following tags: "<tags>"
    And the tags are actually words found from the article <article_name>

    Examples:
      | article_name                                                               | tags                                        |
      | Russia's economy in for a bumpy ride as sanctions bite - BBC News          | economy, noise, cut, russia, sanction       |
      | Russia sentences US teacher to 14 years for cannabis smuggling - BBC News  | basketball, drug, fogel, russia, star       |
