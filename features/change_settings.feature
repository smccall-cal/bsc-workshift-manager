Feature: allow users to access and modify preferences and settings
 
  As a member
  So that I can adjust my settings (password, preferences, times available)
  I want to be able to access and modify my preferences

Background: user preferences have been added to database

  Given the following movies exist:
  | username                | userid | ...          |

  And  I am on the BSCWorkshift member personal page
  Then 10 seed user preferences should exist

Scenario: I should see my preferences and settings when I've logged in and I click on the preferences button
  
Scenario: I should see a reminder message when I've not set my preferences
  
Scenario: I should be told to login when I click the preferences button without logging in
  
Scenario: I modify the times available and the modification should be saved
  
Scenario: I should see an error message when saved available time is less than 5 hours