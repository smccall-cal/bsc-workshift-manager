Then /^I should see all the users/ do
    users = User.all.select {|user| user.role == "User"}
    users.each do |user|
        step ("I should see \"" + user.username + "\"")
    end
end

When /^I click the delete button of "(.*)"/ do |name|
    step ("I press \"" + name + "_delete\"")
end