@wip
Feature: Managers should be able to perform CRUD functions on shifts resources

  As a manager,
  So that I can populate the semester with the required shifts and to manage the shifts should they change,
  I want to be able to add, edit and delete shifts from a particular semester

Background: previous workshifts have been added to database

  Given the following semesters exist:
  | semester_name       | start_date      |  end_date       |
  | Spring 2017         | 10-Jan-2017     |  10-May-2017    |
  | Fall 2017           | 10-Aug-2017     |  10-Dec-2017    |

  And the following shifts exist:
  | semester_id | day       |  time                   | location      |  description       |
  | 1           | Sunday    |  2000-01-01 23:00:00    | garden        |  weeding the plants|
  | 1           | Monday    |  2000-01-01 23:00:00    | kitchen       |  cooking           |

  And I am on the semesters page
  And I follow "Spring 2017"
  Then 2 shifts should exist

Scenario: I should be able to create shifts

  Given I am on the semesters page
  When I follow "Spring 2017"
  And I follow "Create New Shift"
  And I fill in "Shift Location" with "Lounge"
  And I fill in "Shift Description" with "Mopping the floor"
  And I select "Monday" from "Day of the week"
  And I fill in "Time of shift" time field with "06,00"
  And I press "Save Shift"
  Then I should see "Mopping the floor"
  And I should see "Monday"

Scenario: I should be able to edit shifts

  Given I am on the semesters page
  When I follow "Spring 2017"
  And I follow the first "Edit"
  And I fill in "Shift Location" with "Lounge"
  And I fill in "Shift Description" with "Mopping the floor"
  And I select "Monday" from "Day of the week"
  And I fill in "Time of shift" time field with "06,00"
  And I press "Save Shift"
  Then I should see "Mopping the floor"
  And I should see "Monday"

Scenario: I should be able to delete shifts

  Given I am on the semesters page
  When I follow "Spring 2017"
  Then I should see "cooking"
  And I should see "Monday"
  And I click on the first "Delete"
  And I click on the first "Delete"
  Then I should not see "cooking"
  And I should not see "Monday"
