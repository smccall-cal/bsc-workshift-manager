Given /^user "(.*)" have not logged in before/ do |us|
    u = User.find_by_username(us)
    u.init = true
    u.save
end

Then /^user "(.*)" should be in initial state/ do |us|
    expect(User.find_by_username(us).init).to eq(true)
end

Given /^I am logged in as "(.*)" with password "(.*)"/ do |us, pa|
    steps %Q{
        When I am on the home page
        When I log in as "#{us}" with password "#{pa}"
    }
    @username = us
end

Then /^I should be redirected to (.*)/ do |page_name|
    step ("I should be on " + page_name)
end

When /^I set up my new password/ do
    steps %{
        When I fill in "user_password" with "Bar2"
        When I fill in "user_password_confirmation" with "Bar2"
        When I fill in "user_current_password" with "Bar"
        When I press "Update"
    }
end

Given /^I have not set up my password/ do
    step ("user \"" + @username + "\" have not logged in before")
end

Given /^I have not set up my preferences/ do
    User.find_by_username(@username).preferences.destroy
end

When /^I set up my preferences/ do
    click_button("Save Preferences")
end
