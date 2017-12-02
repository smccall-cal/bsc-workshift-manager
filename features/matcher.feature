Feature: Default assignment for shifts

    As a manager,
    so I can save time and find a better solution,
    I want a default pairing to already exist

Background: A manager is logging in for the first time
    Given manager "Manager" exists with password "ManagerBar"
    And I am on the home page
    And I log in as "Manager" with password "ManagerBar"

    And some shift details exist
    And some shifts exist
    And four users exist
    And everyone has preferences


Scenario: The matcher runs (basic integration test)
    When I generate default assignments
    Then I should be on the personal page for "Manager"
