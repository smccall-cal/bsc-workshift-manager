Given /^user "(.*)" exists with password "(.*)"/ do |us, pa|
    User.init(us, pa)
end

When /^(?:|I )am logged in as "(.*)"$/ do |user|
    session[:session_id] = User.find_by(name: user).session_id
end

When /^(?:|I )am not logged in$/ do
    session[:session_id] = nil
end
