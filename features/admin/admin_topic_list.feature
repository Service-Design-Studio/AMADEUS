@admin @topic
Feature: Topic list for  articles
  As an admin of Amadeus who is interested in the Russian-Ukraine war
  So that I can see the breakdown of category for this particular issue
  I want to see the list of topics belong to this issue

  Background:
    Given I am logged in as admin of Amadeus
    And I am viewing topic list page

  @view
  Scenario: viewing the topic under the Russian and Ukraine war
    Then I should see the following topics "Tanks", "Artillery", "UAVs", "Fighter/Bomber Aircraft", "Helicopters", "Missles", "MANPADs", "Infrastructure damage/strike"
    And the option to edit and add topics

  @admin @list @add
    Scenario: trying to add new topic name to the Russian and Ukraine war issue
      When I click on the "New topic" button
      Then I should be redirected to the "Add Topic" page

  @admin @edit
    Scenario: I want to edit UAVs topic name in the list
      When I click on the UAV button
      Then I should be redirected to the "Edit Topic" page

  @admin @back
  Scenario: trying to go back to the home page
    When I click on the "Back to Home" button
    Then I should be redirected to the "Admin" page






