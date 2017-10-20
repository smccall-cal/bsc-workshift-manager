Given /^There exists a user "(.*)" with password "(.*)"/ do |us, pa|
    User.init(us, pa)
end

When /^(?:|I )am logged in as "(.*)"$/ do
    #Insert
end

When /^(?:|I )am not logged in$/ do
    user_controller.logout()
end
