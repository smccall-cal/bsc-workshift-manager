Feature: add users

    As a manager,
    so I can manage who is on our website quickly and specifically,
    I want to be able to add users both in mass and individually

Background: there exists some Manager

    Given manager "Oski" exists with password "BeatStanford"
    And I am not logged in
    And I am on the sign in page
    And I log in as "Oski" with password "BeatStanford"

Scenario: Add a single user as a Manager

    Given I am on the user creation page
    When I fill in "Username" with "A"
    And I fill in "Email" with "a@berkeley.edu"
    And I press "Sign them up"
    Then I should be on the personal page for "Oski"

Scenario: Add a single user as a Manager

    Given I am on the multiple user creation page
    When I fill in "Username" with "A\nB\nC\nD"
    And I fill in "Email" with "a@berkeley.edu\nb@berkeley.edu\nc@berkeley.edu\nd@berkeley.edu"
    And I press "Sign them up"
    Then I should be on the personal page for "Oski"
