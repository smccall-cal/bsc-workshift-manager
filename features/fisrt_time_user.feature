Feature: redirect first-time-user to change-password page and create-preferences page after that

  As a member
  So that I can set up a new password and original preferences
  I want to be directed to the "new password" page the first time I try to log in, and the "make preferences" page after that

Background: user exists in initial state
  
  Given user "Foo" exists with password "Bar"
  And user "Foo" have not logged in before
  Then user "Foo" should be in initial state

#           user        redirect            redirect                redirect
# home page -----> login -----> new password -----> make preferences -----> my preferences
#                                 /\    |                       |
#                       redirect  |     |   user                |   user
#                                 |     \/                      \/
#                               other pages             other pages -----> preferences -----> no preferences
#                                                                   user               redirect

Scenario: I should be redirected to "new password" page when I log in the first time
  
  Given I am on the home page
  When I log in as "Foo" with password "Bar"
  Then I should be redirected to the new password page for "Foo"
  
Scenario: I should be redirected to "make preferences" page after I set up a new password
  
  Given I am logged in as "Foo" with password "Bar"
  And I am on the new password page for "Foo"
  When I set up my new password
  Then I should be redirected to the make preferences page for "Foo"
  
Scenario: I should be redirected to "new password" page if I didn't set up a new password last time I logged in whichever page I'm on
  
  Given I am logged in as "Foo" with password "Bar"
  And I have not set up my password
  When I am on the my preferences page for "Foo"
  Then I should be redirected to the new password page for "Foo"
  
Scenario: I should be redirected to "no preferences" page when I try to see my preferences if I didn't set up my preferences
  
  Given I am logged in as "Foo" with password "Bar"
  And I have not set up my preferences
  And I am on the personal page for "Foo"
  When I follow "My preferences"
  Then I should be redirected to the no preferences page for "Foo"
  And I should see "No preferences."
  
Scenario: I should be redirected to "my preferences" page after I set up my preferences
  
  Given I am logged in as "Foo" with password "Bar"
  And I am on the make preferences page
  When I set up my preferences
  Then I should be redirected to the my preferences page for "Foo"
  And I should see "Your preferences:"