def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
        loop do
            active = page.evaluate_script('jQuery.active')
            break if active == 0
        end
    end
end


Then /^I should (not )?see users with(out)? "(.*)" in "(.*)"$/ do |n1, n2, query, key|
    wait_for_ajax
    @users = User.select{|user| (not (user[key] =~ Regexp.new(query)).nil?)^n2 and user.role == "User"}
    @users.each do |user|
        step "I should " + ((n1)? "not ": "") + "see \"#{user.username}\""
    end
end

Then /^I should see users sorted by "(.*)"$/ do |sort|
    wait_for_ajax
    @users = (@users || User.select{|user| user.role == "User"}).sort_by{|u| u[sort]} # you can do filtering before sorting
    (0..@users.length-2).each do |i|
        step "I should see \""+@users[i].username+"\" before \""+@users[i+1].username+"\""
    end
end

Then /^I should see "(.*)" before "(.*)"$/ do |e1, e2|
    e1_index = page.body =~ Regexp.new(e1)
    e2_index = page.body =~ Regexp.new(e2)
    return false if e1_index.nil? or e2_index.nil?
    expect(e1_index).to be < e2_index
end