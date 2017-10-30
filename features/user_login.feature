Feature: allow users to login / logout, and maintain basic information

    As a member
    So that I can access my other features, but be sure no one else can,
    I want to be able to login and logout.

Background: there exists some user "Foo"

    Given user "Foo" exists with password "Bar"
    And I am not logged in
    And I am on the sign in page
    Then I should see "Log in"

Scenario: A correct login will send me to my page

    When I log in as "Foo" with password "Bar"
    Then I should be on the personal page for "Foo"

Scenario: An incorrect login will send me nowhere

    When I log in as "Foo" with password "Agileisawful"
    Then I should be on the sign in page

Scenario: A login is will only be correct if it is for the right user

    Given user "Foob" exists with password "Barb"
    And I am on the sign in page
    When I log in as "Foob" with password "bar"
    Then I should be on the sign in page
