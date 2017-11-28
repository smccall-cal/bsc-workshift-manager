@javascript
Feature: Users should be able to filter jobs
 
  As a member
  So that I can quickly find what job I want
  I want to be able to filter by type of job

Background: a user's logged in and shifts have been added to database

  Given user "Foo" exists with password "Bar"
  And I am on the sign in page
  And I am logged in as "Foo" with password "Bar"
  And I have set up my password
  And I have not set up my preferences
  And some shift details exist
  And I am on the make preferences page

Scenario: I can filter the jobs of certain key by typing some query
  
  When I select "location" from "key"
  And I fill in "i" for "query"
  And I press "Filter"
  Then I should not see jobs without "i" in "location"
  And I should see jobs with "i" in "location"
  
Scenario: I can filter the jobs of certain key by clicking on some key
  
  When I follow any "Kitchen"
  Then I should not see jobs without "Kitchen" in "location"
  And I should see jobs with "Kitchen" in "location"

Scenario: I can set the rank of the jobs currently displayed
  
  When I select "5" from "rank"
  And I press "Apply on all displayed"
  Then I should see all displayed jobs with rank "5"
  
  