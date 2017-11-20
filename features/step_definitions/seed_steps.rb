Given /^four users exist/ do
    users = [ {username: "Xin Qin", email: "qinxin@berkeley.edu", password: "123456", building: "CZ"},
              {username: "Ting An Yen", email: "fad11204@berkeley.edu", password: "123456", building: "CZ"},
              {username: "Tze Yang Ng", email: "tng016@berkeley.edu", password: "123456", building: "CZ"},
              {username: "Spencer McCall", email: "smccall@berkeley.edu", password: "123456", building: "CZ"}]
    users.each { |user| User.init(user[:username], user[:email], user[:password], user[:building]) }
end

And /^everyone has preferences/ do
    User.all.each{|user|
        steps %Q{
            user "#{user.username}" has set up preferences"
            }
        }
end

And /^some shift details exist/ do
    shift_details = [
            {location: "Kitchen", description: "Food Put Away"},
            {location: "Kitchen", description: "Freezer Clean/Organize"},
            {location: "Kitchen", description: "Fridge Clean/Organize"},
            {location: "Kitchen", description: "Grills"},
            {location: "Kitchen", description: "Surface Clean"},
            {location: "Kitchen", description: "Sweep/Mop"},
            {location: "Kitchen", description: "Clean"},
            {location: "Kitchen", description: "Dishes"},
            {location: "Bathroom", description: "Cleaning"},
            {location: "Bathroom", description: "Deep Clean"}]
    shift_details.each do |detail|
        ShiftDetail.init(detail)
    end
end

And /^some shifts exist/ do
    Semester.init(semester_name: "Fall 2017", start_date: "16-Aug-2017", end_date: "15-Dec-2017")
    shift_templates = [
              {location: "Kitchen", description: "Freezer Clean/Organize", hours: 2, day: "monday", semester_id: 1, user_id: 1},
              {location: "Kitchen", description: "Fridge Clean/Organize", hours: 2, day: "monday", details: "Small Fridge", semester_id: 1, user_id: 2},
              {location: "Kitchen", description: "Fridge Clean/Organize", hours: 2, day: "monday", details: "Walk in Fridge", semester_id: 1, user_id: 3},
              {location: "Kitchen", description: "Grills", hours: 2, day: "monday", semester_id: 1, user_id: 4},
              {location: "Kitchen", description: "Surface Clean", hours: 2, day: "monday", details: "After Dinner", semester_id: 1, user_id: 1},
              {location: "Kitchen", description: "Surface Clean", hours: 2, day: "monday", details: "Before Noon", semester_id: 1, user_id: 2},
              {location: "Kitchen", description: "Sweep/Mop", hours: 2, day: "monday", semester_id: 1, user_id: 3},
              {location: "Kitchen", description: "Clean", hours: 1, day: "monday", details: "PreDinner Cleaning crew (3:30 - 4:30)", semester_id: 1, user_id: 4},
              {location: "Kitchen", description: "Dishes", hours: 2, day: "monday", details: "1 - 3 pm", semester_id: 1, user_id: 1},
              {location: "Kitchen", description: "Dishes", hours: 1, day: "monday", details: "1hour anytime", semester_id: 1, user_id: 2},
              {location: "Kitchen", description: "Dishes", hours: 1, day: "monday", details: "Anytime", semester_id: 1, user_id: 3},
              {location: "Bathroom", description: "Cleaning", hours: 1, day: "monday", floor: "10s", semester_id: 1, user_id: 4},
              {location: "Bathroom", description: "Deep Clean", hours: 1, day: "monday", floor: "10s", semester_id: 1, user_id: 1},
              {location: "Bathroom", description: "Cleaning", hours: 1, day: "monday", floor: "100s", semester_id: 1, user_id: 2},
              {location: "Bathroom", description: "Deep Clean", hours: 1, day: "monday", floor: "100s", details: "testing", semester_id: 1, user_id: 3}]

    shift_templates.each do |template|
        p template[:description]
        ShiftTemplate.init(template)
    end
end

When /^I generate default assignments/ do
    Matcher m = Matcher.new("CZ")
    hash = m.match
end
