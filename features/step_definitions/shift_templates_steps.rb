Given /the following shift_details exist/ do |shift_detail_table|
  shift_detail_table.hashes.each do |sd|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    sd_instance = ShiftDetail.create(location: sd[:location],description: sd[:description])
    sd_instance.save
  end
end

Given /the following shift_templates exist/ do |shift_template_table|
  
  shift_template_table.hashes.each do |st|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    semester = Semester.find_by(semester_name: st[:semester_name])
    st_instance = ShiftTemplate.create(shift_detail_id: st[:sd_id],hours: st[:hours],day: st[:day],user_id: 1)
    semester.shift_templates << st_instance
    st_instance.save
  end
end

Then /(.*) shifts should exist/ do | n_seeds |
  Shift.count.should be n_seeds.to_i
end

Then /(.*) shift_details should exist/ do | n_seeds |
  ShiftDetail.count.should be n_seeds.to_i
end

Then /(.*) shift_templates should exist/ do | n_seeds |
  ShiftTemplate.count.should be n_seeds.to_i
end

Given /today is "(.*)"/ do |date|
  dates = date.split "/"
  Timecop.travel(Time.local(dates[0], dates[1], dates[2]))
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
  within(".table") do
    first(:link, link).click
  end
end

#found on https://devmaheshwari.wordpress.com/2013/09/20/capybara-cheat-sheet/
When /^I click on the first "(.*)"$/ do |link|
  click_button(link, match: :first)
end

Then /^More than "(.*)" shift should exist$/ do |number|
  Shift.count.should > number.to_i
end
