@admin @categoriser_manual
Feature: Manually configure category
  As an admin of Amadeus
  So that I can customize the categories that an article can be assigned to
  I want to be able to add a new or edit existing category to the list of categories

  Background:
    Given I am logged in as an admin of Amadeus
    And I have created the following categories: "Tanks, Artillery, UAVs, Helicopters, Missiles, MANPADs, Fighter Aircraft, Infrastructure Strike"
    When I am on the "Category Bank" page
    Then I should see the following categories: "Tanks, Artillery, UAVs, Helicopters, Missiles, MANPADs, Fighter Aircraft, Infrastructure Strike"
    And I should see the following buttons: "New Category, Back to Home"

  @happy @redirect
  Scenario Outline: Redirect to different page
    Given I am on the "Category Bank" page
    When I click on the "<button_name>" button
    Then I should be redirected to the "<page_name>" page
    And I should see the following buttons: "<button_lists>"

    Examples:
      | button_name  | page_name    | button_lists                              |
      | New Category | New Category | Save, Return                              |
      | Back to Home | Admin Home   | Home, Category Bank, New Upload, Database |

  @happy
  Scenario Outline: Add new non-identical category
    Given I am on the "New Category" page
    When I type in the category "<category_name>"
    And I click on the "Save" button
    Then I should be redirected to the "Category Bank" page
    And I should see the category "<category_name>" in the list of categories
    And I should see a success message "Set new category: <category_name>."

    Examples:
      | category_name |
      | Drones        |
      | Russia        |
      | Ukraine       |
      | War           |
      | Sanction      |

  @sad
  Scenario Outline: Add duplicate category
    Given I am on the "New Category" page
    When I type in the category "<category_name>"
    And I click on the "Save" button
    Then I should see a warning message "<category_name> already exists!"

    Examples:
      | category_name |
      | Tanks         |
      | UAVs          |
      | Helicopters   |
      | Missiles      |
      | MANPADs       |

  @sad
  Scenario: Add blank category
    Given I am on the "New Category" page
    When I type in the category ""
    And I click on the "Save" button
    Then I should see a warning message "Invalid category input!"

  @sad
  Scenario Outline: Add category that name is too long (more than 30 characters)
    Given I am on the "New Category" page
    When I type in the category "<category_name>"
    And I click on the "Save" button
    Then I should see a warning message "Category name is too long!"

    Examples:
      | category_name                                        |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZaBcDeFgHiJkLmNoPqRsTuVwXyZ |
      | WeeTimoErnestZhaoBlongTronHenry                      |

  @sad
  Scenario Outline: Add ambiguous category
    Given I am on the "New Category" page
    When I type in the category "<category_name>"
    And I click on the "Save" button
    And I should see a warning message "Category <category_name> contains special characters!"

    Examples:
      | category_name |
      | $$$           |
      | Oka @@        |
      | ( ͡❛ ͜ʖ ͡❛)   |

  Scenario Outline: View Edit Category page
    Given I am on the "Category Bank" page
    When I click on the category "<category_name>"
    Then I should be redirected to the "<category_name>" Edit Category page
    And I should see the following buttons: "Save, Delete, Return"

    Examples:
      | category_name |
      | Tanks         |
      | UAVs          |
      | Helicopters   |
      | Missiles      |
      | MANPADs       |

  @happy
  Scenario Outline: Delete category
    Given I am on the Edit Category page for the category "<category_name>"
    When I click on the "Delete" button
    Then I should be redirected to the "Category Bank" page
    And I should not see the category "<category_name>" button
    And I should see a warning message "Deleted <category_name>"

    Examples:
      | category_name |
      | Tanks         |
      | UAVs          |
      | Helicopters   |
      | Missiles      |
      | MANPADs       |

  @happy
  Scenario Outline: Edit current category into new non-identical category name
    Given I am on the Edit Category page for the category "UAVs"
    When I edit the category "UAVs" into "<category_name>"
    And I click on the "Save" button
    Then I should be redirected to the "Category Bank" page
    And I should see the category "<category_name>" in the list of categories
    And I should not see the category "UAVs" button
    And I should see a success message "Set new category: <category_name>."

    Examples:
      | category_name |
      | Drones        |
      | Russia        |
      | Ukraine       |
      | War           |
      | Sanction      |

  @sad
  Scenario Outline: Edit current category into an existing category name
    Given I am on the Edit Category page for the category "UAVs"
    When I edit the category "UAVs" into "<category_name>"
    And I click on the "Save" button
    Then I should see a warning message "<category_name> already exists!"

    Examples:
      | category_name |
      | Tanks         |
      | UAVs          |
      | Helicopters   |
      | Missiles      |
      | MANPADs       |

  @sad
  Scenario: Edit current category into category with blank name
    Given I am on the Edit Category page for the category "UAVs"
    When I edit the category "UAVs" into ""
    And I click on the "Save" button
    Then I should see a warning message "Invalid category input!"

  @sad
  Scenario Outline: Edit into category with name that is more than 15 characters
    Given I am on the Edit Category page for the category "UAVs"
    When I edit the category "UAVs" into "<category_name>"
    And I click on the "Save" button
    Then I should see a warning message "Category name is too long!"

    Examples:
      | category_name                                        |
      | aBcDeFgHiJkLmNoPqRsTuVwXyZaBcDeFgHiJkLmNoPqRsTuVwXyZ |
      | WeeTimoErnestZhaoBlongTronHenry                      |

  @sad
  Scenario Outline: Edit current category into category with ambiguous name
    Given I am on the Edit Category page for the category "UAVs"
    When I edit the category "UAVs" into "<category_name>"
    And I click on the "Save" button
    And I should see a warning message "Category <category_name> contains special characters!"

    Examples:
      | category_name |
      | $$$           |
      | Oka @@        |
      | ( ͡❛ ͜ʖ ͡❛)   |
