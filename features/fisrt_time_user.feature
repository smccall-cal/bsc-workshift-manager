Feature: redirect first-time-user to change-password page and create-preferences page after that

  As a member
  So that I can set up a new password and original preferences
  I want to be directed to the "new password" page the first time I try to log in, and the "make preferences" page after that

Background: user exists in initial state
  
  Given user "Foo" exists with password "Bar"
  And user "Foo" haven't logged in yet
  And  I am on the BSCWorkshift home page
  Then user "Foo" should be in initial state

#           user        redirect            redirect                redirect
# home page -----> login -----> new password -----> make preferences -----> my preferences
#                                 /\    |                       |
#                       redirect  |     |   user                |   user
#                                 |     \/                      \/
#                               other pages             other pages -----> preferences -----> no preferences
#                                                                   user               redirect

Scenario: I should be redirected to "new password" page when I log in the first time
  
Scenario: I should be redirected to "make preferences" page after I set up a new password
  
Scenario: I should be redirected to "new password" page if I didn't set up a new password last time I logged in whichever page I'm on
  
Scenario: I should be redirected to "no preferences" page when I try to see my preferences if I didn't set up my preferences
  
Scenario: I should be redirected to "my preferences" page after I set up my preferences