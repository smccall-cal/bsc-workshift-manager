@wip
Feature: Buy sale shifts

Scenario: I can take the shift

  When I follow "Take the shift"
  Then I should see "true"

Scenario: I can cancel take the shift
  When I follow "Cancel take the shift"
  Then I should see "false"
