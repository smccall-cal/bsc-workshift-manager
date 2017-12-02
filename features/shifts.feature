Feature: Managers should be able to perform CRUD functions on shifts

  As a manager,
  So that I can populate the semester with the required shifts and to manage the shifts should they change,
  I want to be able to add, edit and delete shifts from a particular semester

Background: previous workshifts have been added to database
  Given user "user" exists with password "userPass"
  Given user "user2" exists with password "userPass2"

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

  And the following shifts exist:
  | st_id       | is_checked_off       |  date            | user_id     |
  | 1           | True                 |  8-May-2017      | 1           |
  | 1           | False                |  9-May-2017      | 1           |

  Then 2 shift_details should exist
  Then 2 shift_templates should exist
  Then 2 shifts should exist
  And manager "Manager" exists with password "ManagerBar"
  And I am logged in as "Manager" with password "ManagerBar"

Scenario: I should be able to edit shifts

  Given I am on the semester_shifts page
  Then I should not see "user2"
  And I follow the first "Edit"
  Then I should be on the edit shift page for "1"
  Then I should see "Assigned_user"
  Then I should see "user"

Scenario: I should be able to see all shifts

  Given I am on the semester page for "Spring 2017"
  When I follow "View all shifts from this semester"
  Then I should see "Freezer Clean/Organize"
  And I should not see "Deep Clean"

Scenario: I should be able to edit shifts

  Given I am on the semester page for "Spring 2017"
  When I follow "View all shifts from this semester"
  And I follow the first "Edit"
  And I select "Yes" from "Is checked off?"
  And I press "Save Shift"
  Then I should see "true"
