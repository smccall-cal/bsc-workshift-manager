Feature: allow members to login / logout, and maintain basic information

    As a Manager,
    So that I do not need two different log-in accounts (as a member and as a manager)
    I want to be able to log in with a single account and perform functionalities for both members and managers

Background: there exists some manager and some regular user

    Given manager "Manager" exists with password "ManagerBar"
    And user "Regular" exists with password "RegularBar"
    And I am not logged in
    And I am on the sign in page
    Then I should see "Log in"

Scenario: A correct login will send me to my page

    When I log in as "Manager" with password "ManagerBar"
    Then I should be on the personal page for "Manager"

Scenario: I can access regular user pages

    When I log in as "Manager" with password "ManagerBar"
    And I follow "My preferences"
    Then I should be on the preferences page for "Manager"

Scenario: I can access managerial pages

    When I log in as "Manager" with password "ManagerBar"
    And I follow "Add a Resident"
    Then I should be on the user creation page

Scenario: Regular users cannot access managerial pages

    When I log in as "Regular" with password "RegularBar"
    And I follow "Add a Resident"
    Then I should be on the personal page for "Regular"
