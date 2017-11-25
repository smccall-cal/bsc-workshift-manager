Then /^I should (not )?see users with(out)? "(.*)" in "(.*)"$/ do |n1, n2, query, key|
    @users = User.select{|user| (not (user[key] =~ Regexp.new(query)).nil?)^n2 and user.role == "User"}
    @users.each do |user|
        step "I should " + ((n1)? "not ": "") + "see \"#{user.username}\""
    end
end

Then /^I should see users sorted by "(.*)"$/ do |sort|
    @users = (@users || User.select{|user| user.role == "User"}).sort_by{|u| u[sort]} # you can do filtering before sorting
    (0..@users.length-2).each do |i|
        step "I should see /" + @users[i].username + ".*" + @users[i+1].username + "/"
    end
end