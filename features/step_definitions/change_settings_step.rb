Given /^user "(.*)" did not set my preferences before$/ do |name|
    if User.find_by_username(name).preference != nil
        User.find_by_username(name).preference.destroy
    end
end

When /^I make the following modification:$/ do |table|
    step "I follow \"Edit\""
    table.rows_hash.each do |time, val|
        times = time.split "_"
        step "I select \"#{val}\" from \"preference[schedule][#{times[0]}][#{times[1]}]\""
    end
    step "I press \"Save Preferences\""
end

Then /^the displayed availabilities should be consistent with the following:$/ do |table|
    table.rows_hash.each do |time, val|
        step "the \"#{time}\" availability should be \"#{val}\""
    end
end

Then /^the "(.*)" availability should be "(.*)"$/ do |field, val|
    times = field.split "_"
    expect(first(:css, "#preference_schedule_#{times[0]}_#{times[1]}")).to have_content(val)
end

When /^I set all to "-" except the following:$/ do |table|
    step "I set all to \"-\""
    table.rows_hash.each do |time, val|
        times = time.split "_"
        step "I select \"#{val}\" from \"preference[schedule][#{times[0]}][#{times[1]}]\""
    end
end

When /^I set all to "(.*)"$/ do |val|
    Preference.days.each do |d|
        d = d.to_s
        Preference.times.each do |t|
            step "I select \"#{val}\" from \"preference[schedule][#{d}][#{t}]\""
        end
    end
end