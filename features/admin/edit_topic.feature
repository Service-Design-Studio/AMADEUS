@admin @topics
Feature: Upload new Topics under TopicList
    As an admin of Amadeus
    So that I can upload new topics

    Background:
        Given I am logged in as an admin of Amadeus viewing the topic list page
        And have clicked new topic
    
    @admin @view
    Scenario: View TopicList page
        Then I should see the list of topics
        And I should be able to click on the topics to edit it

    @topics @edit @fail
    Scenario: Given that topic "UAVs" exist and I edit another topic into "UAVs" eg. editing "Artillery" into "UAVs"
        Then I should get an error message of "Name has already been taken" and remain on the same page

    @topics @edit @fail
    Scenario: enters an empty string/space and click save
        Then I should get an error message of "Name can't be blank" and "Name is invalid" and remain on the same page

    @topics @edit @fail
    Scenario: enters a special character and click save eg. "*Artillery*"
        Then I should get an error message of "Name is invalid" and remain on the same page

    @topics @edit @fail
    Scenario: enters space input and click save
        Then I should get an error message of "Name can't be blank" and "Name is invalid"

    @topics @edit @fail
    Scenario: enters a phrase with trailing white spaces at the start eg "    ArtilleryAction" and click save
        Then I should get an error message of "Name is invalid" and remain on the same page
    
    @topics @edit @fail
    Scenario: enters a phrase with trailing white spaces at the end eg "Artillery   " and click save
        Then I should get an error message of "Name is invalid" and remain on the same page    

    
    @topics @edit @success
    Scenario: type in a topic that does not exist eg. Special
        Then I should be redirected to the topic list page
        And flash message shwon as "{oldtopicname} updated into #{name}"

    @topics @delete @success
    Scenario: Delete the current topic by pressing the delete button
        Then I should be redirected to the topic list page
        And flash message shown "Deleted #{name}"

    @topics 
    Scenario: clicks on a topic and clicks back to topic list   
        Then I should return to the topic list pag

    
    

     
    

