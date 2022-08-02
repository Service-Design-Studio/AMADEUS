@admin @summariser_upload
Feature: Edit summary
  As an admin of AMADEUS
  So that I can modify the summary to make sure it is accurate
  I want to be able to edit the summary in the article 'Edit' page

  Background:
    Given I am logged in as an admin of AMADEUS
    And I have uploaded these zip files: rus.zip

  @happy
  Scenario Outline: Admin successfully updates summary
    Given I am on the edit page for the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    When I edit the summary into "<summary>"
    And I click on the "Save" button
    Then I should see the summary "<summary>".
    And I should see a success message "Summary updated!"

    Examples:
      | summary                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
      | This is a valid summary with more than 10 words                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
      | This is another valid summary that is less than 100 words but is somehow still super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super long |


  @sad
  Scenario: Admin update summary into empty or blank
    Given I am on the edit page for the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    When I edit the summary into ""
    And I click on the "Save" button
    Then I should still see the old summary belongs to the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    And I should see a warning message "Summary cannot be blank, and must be between 10 to 100 words."


  @sad
  Scenario Outline: Admin update summary that is less than 10 words or more than 100 words
    Given I am on the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News" edit page
    When I edit the summary into "<summary>"
    And I click on the "Save" button
    Then I should still see the old summary belongs to the article "Russia's economy in for a bumpy ride as sanctions bite - BBC News"
    And I should see a warning message "Summary cannot be blank, and must be between 10 to 100 words."

    Examples:
      | summary                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | This is an invalid summary with < 10 words                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | This is another invalid summary that is more than 100 words because it is  super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super super long |


