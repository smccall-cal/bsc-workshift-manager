Then /^I should (not )?see users with(out)? "(.*)" in "(.*)"$/ do |n1, n2, query, key|
    @users = User.select{|user| (not (user[key] =~ Regexp.new(query)).nil?)^n2 and user.role == "User"}
    @users.each do |user|
        step "I should " + ((n1)? "not ": "") + "see \"#{user.username}\""
    end
end

Then /^I should (not )?see jobs with(out)? "(.*)" in "(.*)"$/ do |n1, n2, query, key|
    @shifts = ShiftDetail.select{|sh| (not (sh[key] =~ Regexp.new(query)).nil?)^n2}
    @shifts.each do |sh|
        step "I should " + ((n1)? "not ": "") + "see \"#{sh.to_s_with_space}\""
    end
end

Then /^I should see users sorted by "(.*)"$/ do |sort|
    @users = (@users || User.select{|user| user.role == "User"}).sort_by{|u| u[sort]} # you can do filtering before sorting
    (0..@users.length-2).each do |i|
        step "I should see /" + @users[i].username + ".*" + @users[i+1].username + "/"
    end
end

Then /^I should see jobs sorted by "(.*)"$/ do |sort|
    @shifts = (@shifts || User.all.to_a).sort_by{|s| s[sort]} # you can do filtering before sorting
    (0..@shifts.length-2).each do |i|
        step "I should see /" + @shifts[i].to_s + ".*" + @shifts[i+1].to_s + "/"
    end
end

Then /^I should see all displayed jobs with rank "(.*)"$/ do |rank|
    ranks = page.all(:css, ".show .rank", :visible => true)
    ranks.each do |r|
        expect(r.value).to eq rank
    end
end

When /^I follow any "(.*)"/ do |link|
    first(:link, link).click
end