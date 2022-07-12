@admin @topics
Feature: Edit existing topics from topicslist
    As an admin of Amadeus
    So that I can edit the existing topics from the topic list or delete them

    Background:
        Given I am logged in as an admin of Amadeus viewing the topic list page
        And have clicked on the Topic I want to edit
    
    @admin @view
    Scenario: View TopicList page
        Then I should see the list of topics
        And I should see a button to upload new topic and back to home

    @topics @fail
    Scenario: enter existing topic name eg. Helicopters and click save
        Then I should get an error message of "Topic #{name} has already been taken"

    @topics @fail
    Scenario: enter an empty string and click save
        Then I should get an error message of "Invalid Topic Input"

    @topics @fail
    Scenario: enter spacebars and click save
        Then I should get an error message of "Invalid Topic Input"
    
    @topics @fail
    Scenario: enter trailing white spaces at the start eg "  fire" and click save
        Then I should get an error message of "Topic #{name} starts or ends with a space!"

    @topics @fail
    Scenario: enter trailing white spaces at the end of input eg "fire    " and click save
        Then I should get an error message of "Topic #{name} starts or ends with a space!"
    
    @topics @fail
    Scenario: enter a string containing special characters "!@#$%&*()" except for / eg "Space%"
        Then I should get an error message of "Topic #{name} contains special characters!"

    @topics @success
    Scenario: type in a topic that does not exist eg. War and click save
        Then I should be redirected to the topic list page, with a success message of "War added" 

    @topics @success
    Scenario: type in a topic that has a space between the words eg "Family Day" and click save
        Then I should be redirected to the topic list page, with a success message of "Family Day"
    
    @topics @success
    Scenario: type in a topic that has a / and space between the words eg "Infrastructure damage/strike" and click save
        Then I should be redirected to the topic list page, with a success message of "Infrastructure damage/strike"

    @topics 
    Scenario: clicks on a topic and clicks back to topic list   
        Then I should return to the topic list pag    

