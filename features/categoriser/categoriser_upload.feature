@admin @categoriser_upload
Feature: Edit category linked to an article
  As an admin of Amadeus
  So that I can manage the category that is currently linked to an article
  I want to be able to edit the linked category in the article Edit page

  Background:
    Given I am logged in as an admin of Amadeus
    And I have created the following categories: "Tanks, Artillery, UAVs, Helicopters, Missiles, MANPADs, Fighter Aircraft, Infrastructure Strike"
    And I have uploaded these zip files: rus.zip, uav.zip, ukr.zip
    And I have deleted the following categories: "Infrastructure Strike" from the list of categories

  Scenario Outline: Viewing articles with linked categories in Database page
    Given I am on the "Database" page
    Then I should see the article "<article_name1>" under the category "<category_name>"
    And I should see the following articles with "No Category" label:
      | article_name                                                   |
      | Russia sentences US teacher to 14 years for cannabis smuggling |
      | Ukraine war_ Thousands of civilians trapped in Severodonetsk   |
      | How many Ukrainian refugees are there and where have they gone |

    Examples:
      | article_name1                                                  | category_name |
      | Combat drones_ We are in a new era of warfare - here's why     | UAVs          |
      | Chinese drone firm DJI pauses operations in Russia and Ukraine | UAVs          |

  @happy
  Scenario Outline: Admin submit a category with new non-identical category name
    Given I am on the article "Combat drones_ We are in a new era of warfare - here's why - BBC News" edit page
    When I click on the hyperlink for the category "UAVs"
    And I edit the category "UAVs" into "<category_name>"
    And I click on the "Save" button
    Then I should see the new category "<category_name>"
    And I should see a success message "Set new category: <category_name>."

    Examples:
      | category_name |
      | Drones        |
      | Russia        |
      | Ukraine       |
      | War           |
      | Sanction      |


  @happy
  Scenario: Admin submits without any change
    Given I am on the article "Combat drones_ We are in a new era of warfare - here's why - BBC News" edit page
    When I click on the hyperlink for the category "UAVs"
    And I edit the category "UAVs" into "UAVs"
    And I click on the "Save" button
    Then I should see that the category name "UAVs" has not changed
    Then I should see a warning message "No change!"


  @happy
  Scenario Outline: Admin re-assign the category of an article to an existing category
    Given I am on the article "Combat drones_ We are in a new era of warfare - here's why - BBC News" edit page
    When I click on the hyperlink for the category "UAVs"
    And I edit the category "UAVs" into "<category_name>"
    And I click on the "Save" button
    Then I should see the new category "<category_name>"
    And I should see a success message "Replaced with existing category: <category_name>."

    Examples:
      | category_name |
      | Tanks         |
      | Helicopters   |
      | Missiles      |
      | MANPADs       |

  @sad
  Scenario: Edit current category into category with blank name
    Given I am on the article "Combat drones_ We are in a new era of warfare - here's why - BBC News" edit page
    When I click on the hyperlink for the category "UAVs"
    And I edit the category "UAVs" into ""
    And I click on the "Save" button
    Then I should see that the category name "UAVs" has not changed
    Then I should see a warning message "Category cannot be blank or contain special characters and must be less than 30 characters."

  @sad
  Scenario Outline: Edit current category into category with name that is more than 15 characters
    Given I am on the article "Combat drones_ We are in a new era of warfare - here's why - BBC News" edit page
    When I click on the hyperlink for the category "UAVs"
    And I edit the category "UAVs" into "<category_name>"
    And I click on the "Save" button
    Then I should see a warning message "Category cannot be blank or contain special characters and must be less than 30 characters."

    Examples:
      | category_name                                        |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZaBcDeFgHiJkLmNoPqRsTuVwXyZ |
      | WeeTimoErnestZhaoBlongTronHenry                      |

  @sad
  Scenario Outline: Edit current category into category with ambiguous name
    Given I am on the article "Combat drones_ We are in a new era of warfare - here's why - BBC News" edit page
    When I click on the hyperlink for the category "UAVs"
    And I edit the category "UAVs" into "<category_name>"
    And I click on the "Save" button

    And I should see a warning message "Category cannot be blank or contain special characters and must be less than 30 characters."

    Examples:
      | category_name |
      | $$$           |
      | Oka @@        |
      | ( ͡❛ ͜ʖ ͡❛)   |

  @view
  Scenario: View article Edit page with No category
    Given I am on the article "How many Ukrainian refugees are there and where have they gone_ - BBC News" edit page
    And the article has not been assigned any category
    Then I should see the label "<No Category>"
    And I should see a form with the following categories to select from: "Tanks, Artillery, UAVs, Helicopters, Missiles, MANPADs, Fighter Aircraft"
    And I should see a "Add Category" button

  @happy
  Scenario Outline: Assign a category from the list of categories to an article missing a category
    Given I am on the article "How many Ukrainian refugees are there and where have they gone_ - BBC News" edit page
    And the article has not been assigned any category
    When I select the category "<category_name>"
    And I click on the "Add Category" button
    Then I should see the new category "<category_name>"
    And I should see a success message "Replaced with existing category: <category_name>."

    Examples:
      | category_name    |
      | Tanks            |
      | Artillery        |
      | UAVs             |
      | Helicopters      |
      | Missiles         |
      | MANPADs          |
      | Fighter Aircraft |

  @happy
  Scenario Outline: Successfully creating and assigning a new category to a new article
    Given I am on the article "How many Ukrainian refugees are there and where have they gone_ - BBC News" edit page
    And the article has not been assigned any category
    When I type the category name as "<category_name>"
    And I click on the "Add Category" button
    Then I should see the article assigned to the category "<category_name>"
    And I should see a success message "Set new category: <category_name>."

    Examples:
      | category_name |
      | Drones        |
      | Russia        |
      | Ukraine       |
      | War           |
      | Sanction      |

  @sad
  Scenario: Attempting to create a new category “” (blank), to assign to a new article
    Given I am on the article "How many Ukrainian refugees are there and where have they gone_ - BBC News" edit page
    And the article has not been assigned any category
    When I type the category name as ""
    And I click on the "Add Category" button
    And I should see a warning message "Category cannot be blank or contain special characters and must be less than 30 characters."

  @sad
  Scenario Outline: Attempting to create a new category more than 30 characters long, to assign to a new article
    Given I am on the article "How many Ukrainian refugees are there and where have they gone_ - BBC News" edit page
    And the article has not been assigned any category
    When I type the category name as "<category_name>"
    And I click on the "Add Category" button
    Then I should see a warning message "Category cannot be blank or contain special characters and must be less than 30 characters."

    Examples:
      | category_name                                        |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZaBcDeFgHiJkLmNoPqRsTuVwXyZ |
      | WeeTimoErnestZhaoBlongTronHenry                      |

  @sad
  Scenario Outline: Modify No category into category with ambiguous name
    Given I am on the article "How many Ukrainian refugees are there and where have they gone_ - BBC News" edit page
    And the article has not been assigned any category
    When I type the category name as "<category_name>"
    And I click on the "Add Category" button
    Then I should see a warning message "Category cannot be blank or contain special characters and must be less than 30 characters."

    Examples:
      | category_name |
      | $$$           |
      | Oka @@        |
      | ( ͡❛ ͜ʖ ͡❛)   |
