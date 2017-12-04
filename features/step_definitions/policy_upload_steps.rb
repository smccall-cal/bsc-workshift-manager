Given /^no policy exists$/ do 
    Policy.destroy_all
end

Given /^some policy exists$/ do
    step "no policy exists"
    step "I am on the new policy page"
    step "I upload a file with valid format"
    step "I am on the personal page for \"Oski\""
end

Given /^some policy is uploaded by a manager$/ do
    step "manager \"Oski\" exists with password \"BeatStanford\""
    step "I am not logged in"
    step "I am on the sign in page"
    step "I log in as \"Oski\" with password \"BeatStanford\""
    step "I am on the personal page for \"Oski\""
    step "some policy exists"
    step "I follow \"Sign Out\""
end

When /^I upload a file with valid format$/ do
    attach_file(:policy_policy_file, File.join(Rails.root, 'features', 'upload-files', 'policy_test_file'))
    click_button "Save"
end

Then /^I should get a download$/ do
    result = expect(page.response_headers['Content-Type']).to eq "text/plain"
    if result
        result = expect(page.response_headers['Content-Disposition']).to match(/#{Policy.first.filename}/)
    end
    result
end