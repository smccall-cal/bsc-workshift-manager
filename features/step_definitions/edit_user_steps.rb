When /^I click the edit button of "(.*)"/ do |name|
    step ("I press \"" + name + "_edit\"")
end

Then /^I should( not)? see : (.*)/ do |no, things|
    things.split(", ").each do |thing|
        step ("I should" + ((no)? " not": "") + " see "+ thing)
    end
end