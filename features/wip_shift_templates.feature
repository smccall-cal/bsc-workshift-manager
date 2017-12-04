@wip
Feature: Managers should be able to perform CRUD functions on shifts resources

  As a manager,
  So that I can populate the semester with the required shifts and to manage the shifts should they change,
  I want to be able to add, edit and delete shifts from a particular semester

Background: previous workshifts have been added to database
  Given user "user" exists with password "userPass"

  Given the following semesters exist:
  | semester_name       | start_date      |  end_date       |
  | Spring 2017         | 10-Jan-2017     |  10-May-2017    |
  | Fall 2017           | 10-Aug-2017     |  10-Dec-2017    |

  And the following shift_details exist:
  | location      | description             |
  | Bathroom      | Freezer Clean/Organize  |
  | Kitchen       | Deep Clean              |

  And the following shift_templates exist:
  | sd_id       | day       |  hours  | floor      | details          | semester_name |
  | 1           | Sunday    |  1      | 10s        | Small fridge     | Spring 2017   |
  | 1           | Monday    |  2      |            | Walk-in Frige    | Spring 2017   |

  Then 2 shift_details should exist
  Then 2 shift_templates should exist
  And manager "Manager" exists with password "ManagerBar"
  And I am logged in as "Manager" with password "ManagerBar"

Scenario: I should be able to generate shifts

  Given I am on the semesters page
  When I follow "Spring 2017"
  And I follow "Edit Semester Details"
  And I fill in "End Date" date field with "30" days from today's date
  And I fill in "Start Date" date field with today's date
  And I press "Save Semester"
  And I press "Generate Shift"
  Then More than "1" shift should exist
