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
  
  Given I and on the personal page
  And I am logged in
  And I set my preferences before
  When I press My preferences
  Then I should see my preferences and settings
  
Scenario: I should see a reminder message when I've not set my preferences
  
  Given I and on the personal page
  And I am logged in
  And I didn't set my preferences before
  When I press My preferences
  Then I should see "No preferences"
  
Scenario: I should be told to login when I click the preferences button without logging in
  
  Given I and on the personal page
  And I am not logged in
  When I press My preferences
  Then I should see "Please log in first"
  
Scenario: I modify the times available and the modification should be saved
  
Scenario: I should see an error message when saved available time is less than 5 hours