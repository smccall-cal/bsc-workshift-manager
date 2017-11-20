Feature: Grant Admin's all Managerial powers for all buildings.

    As an Admin,
    So that I can stand in for any Manager, but any Manager cannot do my job,
    I want to access privileges for any building, where any manger can only access privileges for their own building,

Background: there exists some admin, some manager, and some regular user

    Given admin "Admin" exists with password "AdminBar"
    And manager "Manager" exists with password "ManagerBar"
    And user "Regular" exists with password "RegularBar"
    And I am not logged in
    And I am on the sign in page
    Then I should see "Log in"

Scenario: I should be able to log in
    When I log in as "Admin" with password "AdminBar"
    Then I should be on the personal page for "Admin"

Scenario: I should be able to sign up someone for any building

    When I log in as "Admin" with password "AdminBar"
    And I go to the user creation page
    And I select "CZ" from "Building"
    And I select "Kingman" from "Building"
    And I select "Cloyne" from "Building"
    Then I should be on the user creation page
