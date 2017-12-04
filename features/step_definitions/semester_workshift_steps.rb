Given /the following semesters exist/ do |semester_table|
  semester_table.hashes.each do |semester|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    semester_instance = Semester.create(semester_name: semester[:semester_name],start_date: semester[:start_date], end_date: semester[:end_date])
    semester_instance.save
  end
end

Then /(.*) semesters should exist/ do | n_seeds |
  Semester.count.should be n_seeds.to_i
end

#found on hashrocket.com
When /^I fill in "(.*?)" date field with "(.*?)"$/ do |field_name, date_components|
  label = find("label", text: field_name)
  select_base_id = label[:for]
  date_components.split(",").each_with_index do |value, index|
    select value.strip, from: "#{select_base_id}_#{index+1}i"
  end
end

When /^I fill in "(.*?)" date field with today's date$/ do |field_name|
  date_components = Date.today.strftime("%Y,%b,%-d")
  label = find("label", text: field_name)
  select_base_id = label[:for]
  date_components.split(",").each_with_index do |value, index|
    select value.strip, from: "#{select_base_id}_#{index+1}i"
  end
end

When /^I fill in "(.*?)" date field with "(.*?)" days from today's date$/ do |field_name, number|
  date_components = (Date.today + number.to_i).strftime("%Y,%b,%-d")
  label = find("label", text: field_name)
  select_base_id = label[:for]
  date_components.split(",").each_with_index do |value, index|
    select value.strip, from: "#{select_base_id}_#{index+1}i"
  end
end