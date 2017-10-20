Feature: allow users to login / logout, and maintain basic information

    As a member
    So that I can access my other features, but be sure no one else can,
    I want to be able to login and logout.

Background: there exists some user "Foo"

    Given user "Foo" exists with password "Bar"
    And I am on the home page
    And I am not logged in
    Then I should see "Login"

Scenario: A correct login will send me to my page

    When I select in "Foo" from "Username"
    And fill in "Password" with "Bar"
    And press "Login"
    Then I should be on the personal page for "Foo"

Scenario: An incorrect login will send me nowhere

    When I select in "Foo" from "Username"
    And fill in "Password" with "Agileisawful"
    And press "Login"
    Then I should be on the home page
    And I should see "Incorrect Username or Password"

Scenario: A login is will only be correct if it is for the right user

    Given user "Foob" exists with password "Barb"
    When I select in "Foob" from "Username"
    And fill in "Password" with "Bar"
    And press "Login"
    Then I should be on the home page
    And I should see "Incorrect Username or Password"
