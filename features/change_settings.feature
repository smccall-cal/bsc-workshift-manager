Feature: allow users to access and modify preferences and settings
 
  As a member
  So that I can adjust my settings (password, preferences, times available)
  I want to be able to access and modify my preferences

Background: user preferences have been added to database

  Given the following preferences exist:
    | userid | shift | schedule |

  And  I am on the BSCWorkshift member personal page
  Then 10 seed user preferences should exist

Scenario: I should see my preferences and settings when I've logged in and I click on the preferences button
  
  Given I am on the personal page
  And I am logged in
  And I set my preferences before
  When I press My preferences
  Then I should see my preferences and settings
  
Scenario: I should see a reminder message when I've not set my preferences
  
  Given I am on the personal page
  And I am logged in
  And I didn't set my preferences before
  When I press My preferences
  Then I should see "No preferences"
  
Scenario: I should be told to login when I click the preferences button without logging in
  
  Given I am on the personal page
  And I am not logged in
  When I press My preferences
  Then I should see "Please log in first"
  
Scenario: I modify the times available and the modification should be saved
  
  Given I am on the preferences page
  When I make the following modification:
    | Mon_8pm | + |
    | Wed_9pm | - |
    | Thu_10am | ? |
    | Sun_12pm | x |
  # When I modify Mon_8pm with + 
    # When I press modify preferences
    # And I select + for Mon_8pm
    # And I press save changes
  Then I should be on the preferences page
  And the Mon_8pm within schedule should contain +
  
Scenario: I should see an error message when saved available time is less than 5 hours
  
  Given I am on the preferences page
  When I fill my preferences with the following:
    | Mon_8pm | + |
    | Wed_9pm | + |
    | Thu_10am | + |
    | Sun_12pm | + |
  Then I should see "Available time should be at least 5 hours"
  And I should not see "Preference was successfully created"
  