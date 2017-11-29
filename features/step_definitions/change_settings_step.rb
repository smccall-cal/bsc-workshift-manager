Given /I set my preferences before/ do
  current_user.preference.build
end

Given /I didn't set my preferences before/  do
  if current_user.preference != nil
      current_user.preference.destroy
  end
end

Given /the following preferences exist:/ do |table|
    table.raw.each{|userid, shift, schedule|}
end
