Feature: Users should be able to see the responsibilities
 
  As a member
  So I can decide which job I want
  I should be able to see the responsibilities of each shift

Background: shift responsibilities have been added to database

  Given the following shift responsibilities exist:
  | 100's Roof Clean/Sweep        | Exterior      |
  | 10's Hallway                  | Interior      |
  | After Dinner Food Put Away    | Kitchen       |
  | 100's Bathroom                | Rotating Shift|
  | WR - Can's/Bottle             | WR            |


  And I am on the BSCWorkshift member personal page
  Then 10 seed shift responsibilities should exist

Scenario: I should see responsibilities of each shift when I've logged in and I click on the preferences button
  
  Given I and on the personal page
  And I am logged in
  When I press My responsibilities
  Then I should see shift responsibilities

Scenario: I should see responsibilities sorted by type

  When I'm on the responsibilities page
  And I press Exterior Jobs
  Then I should see "100's Roof Clean/Sweep"


 
