Feature: edit users

    As a manager,
    so I can edit some user information if something's wrong,
    I want to be able to edit user information

Background: there exists some Manager

    Given manager "Oski" exists with password "BeatStanford"
    And I am not logged in
    And I am on the sign in page
    And I log in as "Oski" with password "BeatStanford"
    And user "Foo" exists with password "Bar"

Scenario: Edit a user as a Manager

    Given I am on the manage residents page
    When I click the edit button of "Foo"
    And I fill in "Username" with "foo2"
    And I fill in "Email" with "foo2@berkeley.edu"
    And I press "Save"
    Then I should be on the manage residents page
    And I should see : "foo2", "foo2@berkeley.edu"
    And I should not see : "Foo", "Foo@berkeley.edu"
