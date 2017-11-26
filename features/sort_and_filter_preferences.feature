Feature: Users should be able to sort or filter jobs
 
  As a member
  So that I can quickly find what job I want
  I want to be able to filter / sort by type of job

Background: shift responsibilities have been added to database

  Given user "Foo" exists with password "Bar"
  And I am not logged in
  And I am on the sign in page
  And I log in as "Foo" with password "Bar"
  And some shift details exist

Scenario: I can filter the jobs of certain type
  
  
Scenario: I can sort the jobs with certain keys
  
  
Scenario: I can set the rank of the jobs currently displayed
  
  
Scenario: I can set the rank of some jobs of some type which may not be displayed now