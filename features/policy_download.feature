Feature: allow members to download the policy document

    As a member,
    so that I can view the policies,
    I want to be able to download a policy doc.
    
Background: there exists some user and a policy doc
    
    Given some policy is uploaded by a manager
    Given user "Foo" exists with password "Bar"
    And I am logged in as "Foo" with password "Bar"
    And I have set up my password
    And I am on the personal page for "Foo"
    
Scenario: I can download the policy document from my personal page as a member
  
    When I follow "Download Workshift Policy Document"
    Then I should get a download