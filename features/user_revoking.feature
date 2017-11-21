Feature: uesr revoking

    As a manager,
    so I can control who has access to the site,
    I want to be able to delete members.

Background: there exists some Manager

    Given manager "Oski" exists with password "BeatStanford"
    And I am not logged in
    And I am on the sign in page
    And I log in as "Oski" with password "BeatStanford"
    And user "Foo" exists with password "Bar"

Scenario: See all current users
  
    Given I am on the personal page for "Oski"
    When I follow "Delete Residents"
    Then I should see all the users

Scenario: Delete a user as a Manager

    Given I am on the user revoking page
    When I click the delete button of "Foo"
    Then I should not see "Foo"
    And I should be on the user revoking page
