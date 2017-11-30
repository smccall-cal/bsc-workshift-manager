Feature: Ensure Managerial Features are only accessible to Managers

    As a Manager,
    So that I can be sure my regular residents cannot access sensitive features,
    I want to be sure there is no possible way to access these features without being a manager

Background: there exists some manager and some regular user

    Given manager "Manager" exists with password "ManagerBar"
    And user "Regular" exists with password "RegularBar"
    And I am not logged in
    And I am on the sign in page
    Then I should not see "Sign up"

Scenario: Navigating to the URL while not signed in will redirect

    When I go to the user creation page
    Then I should be on the sign in page

Scenario: Navigating to the URL while signed in  as a user will redirect

    When I log in as "Regular" with password "RegularBar"
    And I go to the user creation page
    Then I should be on the personal page for "Regular"

Scenario: The link does not appear for non-managers

    When I log in as "Regular" with password "RegularBar"
    Then I should not see "Add a Resident"

Scenario: The link does appear for managers

    When I log in as "Manager" with password "ManagerBar"
    Then I should see "Add a Resident"
