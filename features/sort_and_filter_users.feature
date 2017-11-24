@javascript
Feature: Managers should be able to sort or filter users
 
  As a manager
  So that I can quickly find what user I want to manage
  I want to be able to filter / sort users

Background: there exists some users and a manager

  Given manager "Oski" exists with password "BeatStanford"
  And I am on the sign in page
  And I log in as "Oski" with password "BeatStanford"
  And four users exist
  And I am on the manage residents page

Scenario: I can filter the users by typing some query of certain key
  
  When I select "username" from "key"
  And I fill in "i" for "query"
  And I press "Search"
  Then I should see users with "i" in "username"
  And I should not see users without "i" in "username"
  
Scenario: I can sort the users with certain keys
  
  When I follow "Username"
  Then I should see users sorted by "username"