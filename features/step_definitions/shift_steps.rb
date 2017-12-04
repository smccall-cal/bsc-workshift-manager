Given /the following shifts exist/ do |shift_table|
  shift_table.hashes.each do |shift|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    shift_instance = Shift.create(shift_template_id: shift[:st_id],is_checked_off: shift[:is_checked_off], date: shift[:date],user_id: shift[:user_id])
    shift_instance.save
  end
end