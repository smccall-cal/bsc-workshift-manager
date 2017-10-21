Feature: allow users to login / logout, and maintain basic information

    As a member
    So that I can access my other features, but be sure no one else can,
    I want to be able to login and logout.

Background: there exists some user "Foo"

    Given user "Foo" exists with password "Bar"
    And I am not logged in
    And I am on the home page
    Then I should see "Login"

Scenario: A correct login will send me to my page

    When I select "Foo" from "username"
    And fill in "password" with "Bar"
    And press "Login"
    Then I should be on the personal page for "Foo"

Scenario: An incorrect login will send me nowhere

    When I select "Foo" from "username"
    And fill in "password" with "Agileisawful"
    And press "Login"
    Then I should be on the home page

Scenario: A login is will only be correct if it is for the right user

    Given user "Foob" exists with password "Barb"
    And I am on the home page
    When I select "Foob" from "username"
    And fill in "password" with "Bar"
    And press "Login"
    Then I should be on the home page
