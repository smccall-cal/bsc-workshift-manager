Feature: Managers should be able to sort or filter users
 
  As a manager
  So that I can quickly find what user I want to manage
  I want to be able to filter / sort users

Background: there exists some users and a manager

  Given manager "Oski" exists with password "BeatStanford"
  And I am not logged in
  And I am on the sign in page
  And I log in as "Oski" with password "BeatStanford"
  And four users exist

Scenario: I can filter the users by typing some substring of name
  
  
Scenario: I can sort the users with certain keys
  
  
  