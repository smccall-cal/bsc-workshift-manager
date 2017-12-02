Feature: Managers should be able to input details of upcoming semester workshift and view details of previous semesters

  As a manager,
  So that I may design the work shift calendar for the semester ahead,
  I want to be specify the type, frequency, timings and other necessary information required and the application will generate the work shift calendar for me.

Background: previous workshifts have been added to database

  Given the following semesters exist:
  | semester_name       | start_date      |  end_date       |
  | Spring 2017         | 10-Jan-2017     |  10-May-2017    |
  | Fall 2017           | 10-Aug-2017     |  10-Dec-2017    |

  And manager "Manager" exists with password "ManagerBar"
  And I am logged in as "Manager" with password "ManagerBar"
  And I am on the semesters page
  Then 2 semesters should exist

Scenario: Users without manager privileges should not be able to view this page
  
  Given user "user" exists with password "userpass"
  And I am not logged in
  And I am logged in as "user" with password "userpass"
  And I am on the semesters page
  Then I should not see "Spring 2017"

Scenario: I should be able to see details of previous semesters

  Given I am on the semesters page
  When I follow "Spring 2017"
  Then I should see "10 January 2017"
  And I should see "10 May 2017"

Scenario: I should be able to create a new semester

  Given I am on the semesters page
  And I follow "Create new semester"
  And I fill in "Semester Name" with "Spring 2018"
  And I fill in "End Date" date field with "2017, Aug, 25"
  And I fill in "Start Date" date field with "2017, Dec, 25"
  And I press "Save Semester"
  Then I should see "Spring 2018"
  And I should be on the semesters page

Scenario: I should be able to edit a semester

  Given I am on the semesters page
  And I follow "Spring 2017"
  And I follow "Edit Semester Details"
  And I fill in "Semester Name" with "Spring 2018"
  And I fill in "End Date" date field with "2018, Aug, 25"
  And I fill in "Start Date" date field with "2018, Dec, 25"
  And I press "Save Semester"
  Then I should see "Spring 2018"
  And I should be on the semester page for "Spring 2018"
  Then I should see "25 August 2018"
  Then I should see "25 December 2018"
  
Scenario: I should be able to delete a semester

  Given I am on the semesters page
  And I follow "Spring 2017"
  And I press "Delete this Semester"
  And I should be on the semesters page
  Then I should not see "Spring 2017"