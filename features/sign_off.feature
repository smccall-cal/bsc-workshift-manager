@javascript
Feature: Sign Off
    As a user
    So that I can get credit for my work
    I would like to be able to be signed off, and to sign others off

Background: Shifts are available
    Given manager "Manager" exists with password "ManagerBar"
    And I am on the home page
    And I log in as "Manager" with password "ManagerBar"

    And some shift details exist
    And some shifts exist
    And four users exist
    And everyone has preferences
    And I generate default assignments
    And I am on the home page

Scenario: I can filter by workshifter
    When I follow "Sign Off"
    And I select "Xin Qin" from "filter"
    And I press "Filter"

Scenario: I can sign someone off
    When I follow "Sign Off"
    And I select "Xin Qin" from "filter"
    And I press "Filter"

Scenario: I can sign someone off when not signed in
    When I follow "Sign Out"
    And I follow "Sign Off"
    And I select "Xin Qin" from "filter"
    And I press "Filter"
    And I select "Manager" from "verifier"
    And I fill in "password" with "ManagerBar"
    And I press "Sign off!"
