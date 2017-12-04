Feature: allow managers to access and modify a policy document

    As a manager,
    so that I can change the policies,
    I want to be able to upload and reupload a policy doc, viewable to the users.
    
Background: there exists some manager
    
    Given manager "Oski" exists with password "BeatStanford"
    And I am not logged in
    And I am on the sign in page
    And I log in as "Oski" with password "BeatStanford"
    And I am on the personal page for "Oski"
    
Scenario: a manager can upload a policy document if there's not any yet
    
    Given no policy exists
    When I follow "Manage Workshift Policy Document"
    Then I should be on the new policy page

Scenario: a manager can upload a policy document
  
    Given no policy exists
    When I follow "Manage Workshift Policy Document"
    And I upload a file with valid format
    Then I should be on the policy page
    And I should see "Policy was successfully created."
    
Scenario: a manager can edit the policy document
  
    Given some policy exists
    When I follow "Manage Workshift Policy Document"
    And I follow "Edit"
    And I upload a file with valid format
    Then I should be on the policy page
    And I should see "Policy was successfully updated."

Scenario: a manager can delete the policy document
  
    Given some policy exists
    When I follow "Manage Workshift Policy Document"
    And I follow "Delete"
    Then I should be on the new policy page
    And I should see "New policy"
    
Scenario: a manager can download the policy document
  
    Given some policy exists
    When I follow "Manage Workshift Policy Document"
    And I follow "Download Policy"
    Then I should get a download