Feature: allow users to access and modify preferences and settings

  As a member
  So that I can adjust my settings (password, preferences, times available)
  I want to be able to access and modify my preferences

Background: user preferences have been added to database
  Given user "Foo" exists with password "Bar"
  And I am logged in as "Foo" with password "Bar"
  And I have set up my password
  And some shift details exist

Scenario: I should see my preferences and settings when I've logged in and I click on the preferences button

  Given I am on the personal page for "Foo"
  And user "Foo" has set up preferences
  When I follow "My preferences"
  Then I should see "Your preferences: "

Scenario: I should see a reminder message when I've not set my preferences

  Given I am on the personal page for "Foo"
  And user "Foo" did not set my preferences before
  When I follow "My preferences"
  Then I should see "No preferences."

Scenario: I modify the times available and the modification should be saved

  Given user "Foo" has set up preferences
  And I am on the preferences page for "Foo"
  When I make the following modification:
    | Monday_8pm | + |
    | Wednesday_9pm | - |
    | Thursday_10am | ? |
    | Sunday_12pm | x |
  Then I should be on the my preferences page for "Foo"
  And the displayed availabilities should be consistent with the following:
    | Monday_8pm | + |
    | Wednesday_9pm | - |
    | Thursday_10am | ? |
    | Sunday_12pm | x |

Scenario: I should see an error message when saved available time is less than 5 hours

  Given I am on the make preferences page for "Foo"
  When I set all to "-" except the following:
    | Monday_8pm | + |
    | Wednesday_9pm | + |
    | Thursday_10am | + |
    | Sunday_12pm | + |
  And I press "Save Preferences"
  Then I should see "Available time should be at least 5 hours."
  And I should not see "Preference was successfully created."
  And I should be on the make preferences page for "Foo"
