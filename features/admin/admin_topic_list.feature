@admin @topics @first
Feature: Topic list for articles
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can see the breakdown of category for this particular issue
  I want to see the list of topics belong to this issue

  Background:
    Given I am logged in as admin of Amadeus
    And I am viewing topic list page under the Russian-Ukraine war issue

  @view
  Scenario: viewing the topic under the Russian and Ukraine war
    Then I should see the following topics "Tanks", "Artillery", "UAVs", "Helicopters", "Missles", "MANPADs"
    And the option to edit and add topics

  @add @redirect
  Scenario: trying to add new topic name to the Russian and Ukraine war issue
    When I click on the "New topic" button
    Then I should be redirected to the "Add Topic" page

  @edit
  Scenario Outline: I want to edit the topic <topic> in the list
    When I click on the "<topic>" button
    Then I should be redirected to the "Edit Topic" page

    Examples:
    | topic |
    | UAVs  |
    | Tanks |
    | Artillery |

  @back
  Scenario: finished viewing the Russian-Ukraine war and want to do some admin work
    When I click on the "Back to Home" button
    Then I should be redirected to the "Admin" page






