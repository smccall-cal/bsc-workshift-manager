Given /the following shifts exist/ do |shift_table|
  shift_table.hashes.each do |shift|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    shift_instance = Shift.create(semester_id: shift[:semester_id],day: shift[:day], time: shift[:time],location: shift[:location],description: shift[:description])
    shift_instance.save
  end
end

Then /(.*) shifts should exist/ do | n_seeds |
  Shift.count.should be n_seeds.to_i
end

#found on hashrocket.com
When /^I fill in "(.*?)" time field with "(.*?)"$/ do |field_name, time_components|
  label = find("label", text: field_name)
  select_base_id = label[:for]
  time_components.split(",").each_with_index do |value, index|
    select value.strip, from: "#{select_base_id}_#{index+4}i"
  end
end

When /^I follow the first "(.*)"$/ do |link|
  first(:link, link).click
end

#found on https://devmaheshwari.wordpress.com/2013/09/20/capybara-cheat-sheet/
When /^I click on the first "(.*)"$/ do |link|
  click_button(link, match: :first)
end