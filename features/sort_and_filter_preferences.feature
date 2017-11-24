Feature: Users should be able to sort or filter jobs
 
  As a member
  So that I can quickly find what job I want
  I want to be able to filter / sort by type of job

Background: shift responsibilities have been added to database

  Given the following shifts with types exist:
  | 100's Roof Clean/Sweep        | Exterior      |
  | 10's Hallway                  | Interior      |
  | After Dinner Food Put Away    | Kitchen       |
  | 100's Bathroom                | Rotating Shift|
  | WR - Can's/Bottle             | WR            |


  And I am on the BSCWorkshift member personal page
  Then 5 seed shift responsibilities should exist

Scenario: I can filter the jobs of certain type
  
  Given I and on the personal page
  And I am logged in
  When I press My responsibilities
  Then I should see shift responsibilities
  
Scenario: I can sort the jobs with certain keys
  
  
Scenario: I can set the rank of the jobs currently displayed
  
  
Scenario: I can set the rank of some jobs of some type which may not be displayed now