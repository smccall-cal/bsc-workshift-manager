Given /^user "(.*)" exists with password "(.*)"/ do |us, pa|
    User.init(us, us + "@berkeley.edu", pa + "123456", "CZ")
    User.find_by_username(us).unset_init
end

Given /^manager "(.*)" exists with password "(.*)"/ do |us, pa|
    User.init(us, us + "@berkeley.edu", pa + "123456", "CZ")
    User.find_by_username(us).promote("Manager").unset_init
end

Given /^admin "(.*)" exists with password "(.*)"/ do |us, pa|
    User.init(us, us + "@berkeley.edu", pa + "123456", "CZ")
    User.find_by_username(us).promote("Admin").unset_init
end


When /^(?:|I )log in as "(.*)" with password "(.*)"$/ do |us, pa|
    pass = pa + "123456"

    select(us, from: "user_email")
    fill_in("user_password", with: pass)
    click_button("Log in")
end

When /^(?:|I )am not logged in$/ do
    page.driver.submit :delete, "/users/sign_out", {}
end
