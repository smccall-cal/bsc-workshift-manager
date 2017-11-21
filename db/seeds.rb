# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [ {username: "Xin Qin", email: "qinxin@berkeley.edu", password: "123456", building: "CZ"},
          {username: "Ting An Yen", email: "fad11204@berkeley.edu", password: "123456", building: "Northside"},
          {username: "Christopher Hamilton", email: "cshamilton@berkeley.edu", password: "123456", building: "Davis"},
          {username: "Kevin Liu", email: "softandcozy@berkeley.edu", password: "123456", building: "CZ"},
          {username: "Tze Yang Ng", email: "tng016@berkeley.edu", password: "123456", building: "Northside"},
          {username: "Spencer McCall", email: "smccall@berkeley.edu", password: "123456", building: "Davis"},
          {username: "Oski", email: "oski@berkeley.edu", password: "123456", building: "CZ"},
          {username: "Chancellor Christ", email: "christ@berkeley.edu", password: "123456", building: "Davis"}]

users.each do |user|
  User.init(user[:username], user[:email], user[:password], user[:building])
end

User.find_by_username("Oski").promote("Manager").unset_init
User.find_by_username("Chancellor Christ").promote("Admin").unset_init
User.find_by_username("Kevin Liu").unset_init


semesters = [ {semester_name: "Fall 2017", start_date: "16-Aug-2017", end_date: "15-Dec-2017"},
          {semester_name: "Spring 2018", start_date: "09-Jan-2017", end_date: "11-May-2017"}]

semesters.each do |semester|
  Semester.init(semester)
end

shift_details = [ {location: "Roof", description: "Clean/Sweep"},
          {location: "Balcony", description: "Surface Clean"},
          {location: "Balcony", description: "Sweep/Mop"},
          {location: "Courtyard (Back)", description: "Organize & Sweep"},
          {location: "Courtyard (Front)", description: "Organize & Sweep"},
          {location: "Garage & Elevator", description: "Clean"},
          {location: "Hallway", description: "Sweep"},
          {location: "Stairwell (Front+Back)", description: "Sweep/Mop"},
          {location: "Common Room", description: "Surface Clean"},
          {location: "Common Room", description: "Sweep/Mop"},
          {location: "Front Entrance", description: "Sweep/Mop"},
          {location: "Laundry Room", description: "Tidy-up"},
          {location: "Mop Closet", description: "Clean"},
          {location: "RedRoom", description: "Surface Clean"},
          {location: "Study Room", description: "Surfaces & Vaccuum"},
          {location: "Kitchen", description: "Food Put Away"},
          {location: "Kitchen", description: "Freezer Clean/Organize"},
          {location: "Kitchen", description: "Fridge Clean/Organize"},
          {location: "Kitchen", description: "Grills"},
          {location: "Kitchen", description: "Surface Clean"},
          {location: "Kitchen", description: "Sweep/Mop"},
          {location: "Kitchen", description: "Clean"},
          {location: "Kitchen", description: "Dishes"},
          {location: "Kitchen", description: "Pots"},
          {location: "Outer Kitchen", description: "Clean"},
          {location: "Pantry", description: "Organize"},
          {location: "Bathroom", description: "Cleaning"},
          {location: "Bathroom", description: "Deep Clean"},
          {location: "100s & 10s side back stairwell", description: "sweep & mop"},
          {location: "Receiving Bay", description: "Putaway"},
          {location: "Ito's (10s Roof) Lounge", description: "Sweep/Mop"},
          {location: "Red Room", description: "Surface Clean"},
          {location: "Red Room", description: "Sweep & Mop"},
          {location: "Snack Room", description: "Snack Shift"},
          {location: "Waste Area", description: "Sweep"}]

shift_details.each do |detail|
  ShiftDetail.init(detail)
end

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
          {location: "Kitchen", description: "Dishes", hours: 1, day: "monday", details: "1 hour anytime", semester_id: 1, user_id: 2},
          {location: "Kitchen", description: "Dishes", hours: 1, day: "monday", details: "Anytime", semester_id: 1, user_id: 3},
          {location: "Bathroom", description: "Cleaning", hours: 1, day: "monday", floor: "10s", semester_id: 1, user_id: 4},
          {location: "Bathroom", description: "Deep Clean", hours: 1, day: "monday", floor: "10s", semester_id: 1, user_id: 1},
          {location: "Bathroom", description: "Cleaning", hours: 1, day: "monday", floor: "100s", semester_id: 1, user_id: 2},
          {location: "Bathroom", description: "Deep Clean", hours: 1, day: "monday", floor: "100s", details: "testing", semester_id: 1, user_id: 3}]

shift_templates.each do |template|
  ShiftTemplate.init(template)
end

shifts = [ {date: "16-Aug-2017", user_email: "tng016@berkeley.edu", shift_template_id: 3},
           {date: "23-Aug-2017", user_email: "tng016@berkeley.edu", shift_template_id: 3},
           {date: "30-Aug-2017", user_email: "tng016@berkeley.edu", shift_template_id: 3}]

shifts.each do |shift|
  Shift.init(shift)
end

# Original Shifts
# shifts = [ {location: "100", description: "Roof Clean/Sweep"},
#           {location: "Balcony", description: "Surface Clean"},
#           {location: "Balcony", description: "Sweep/Mop"},
#           {location: "Courtyard (Back)", description: "Organize & Sweep"},
#           {location: "Courtyard (Front)", description: "Organize & Sweep"},
#           {location: "Garage & Elevator", description: "Clean"},
#           {location: "10", description: "Hallway"},
#           {location: "10", description: "Stairwell (Front+Back) Sweep/Mop"},
#           {location: "100", description: "Hallway"},
#           {location: "100", description: "Stairwell (Front+Back) Sweep/Mop"},
#           {location: "20", description: "Hallway"},
#           {location: "200", description: "Hallway"},
#           {location: "30", description: "Hallway"},
#           {location: "300", description: "Hallway"},
#           {location: "40", description: "Hallway"},
#           {location: "Common Room", description: "Surface Clean (Pre-Brunch)"},
#           {location: "Common Room", description: "Surface Clean (Pre-Dinner)"},
#           {location: "Common Room", description: "Sweep/Mop"},
#           {location: "Front Entrance", description: "Sweep/Mop"},
#           {location: "Laundry Room", description: "???"},
#           {location: "Mop Closet", description: "Clean"},
#           {location: "RedRoom", description: "Surface Clean"},
#           {location: "Study Room", description: "Surfaces & Vaccuum"},
#           {location: "After Dinner", description: "Food Put Away"},
#           {location: "IKC", description: "Permanent"},
#           {location: "Kitchen", description: "Freezer Clean/Organize"},
#           {location: "Kitchen", description: "Fridge (Small) Clean/Organize"},
#           {location: "Kitchen", description: "Fridge (Walk-in) Clean/Organize"},
#           {location: "Kitchen", description: "Grills"},
#           {location: "Kitchen", description: "Surface Clean (after dinner)"},
#           {location: "Kitchen", description: "Surface Clean (before noon)"},
#           {location: "Kitchen", description: "Sweep/Mop"},
#           {location: "Outer Kitchen", description: "Clean (After Dinner) "},
#           {location: "Outer Kitchen", description: "Clean (ANYTIME BEFORE DINNER)"},
#           {location: "Pantry", description: "Organize"},
#           {location: "Kitchen", description: "Pre-Dinner Clean Crew (3:30-4:30)"},
#           {location: "10", description: "Bathroom"},
#           {location: "10", description: "Bathroom Deep Clean"},
#           {location: "100", description: "Bathroom"},
#           {location: "100", description: "Bathroom Deep Clean"},
#           {location: "20", description: "Bathroom"},
#           {location: "20", description: "Bathroom Deep Clean"},
#           {location: "200", description: "Bathroom"},
#           {location: "200", description: "Bathroom Deep Clean"},
#           {location: "30", description: "Bathroom"},
#           {location: "30", description: "Bathroom Deep Clean"},
#           {location: "300", description: "Bathroom"},
#           {location: "300", description: "Bathroom Deep Clean"},
#           {location: "40", description: "Bathroom"},
#           {location: "40", description: "Bathroom Deep Clean"},
#           {location: "???", description: "ICKY (Intensley Cleaning Krackistan Yo)"},
#           {location: "100s & 10s side back stairwell", description: "sweep & mop"},
#           {location: "Kitchen", description: "After Brunch Food Put Away"},
#           {location: "Kitchen", description: "After Dinner Clean"},
#           {location: "???", description: "Costco Putaway"},
#           {location: "???", description: "Dairy Putaway"},
#           {location: "???", description: "Non-perishables putaway"},
#           {location: "???", description: "Perishables putaway"},
#           {location: "???", description: "Produce putaway"},
#           {location: "Kitchen", description: "Dishes (1 - 3 pm)"},
#           {location: "Kitchen", description: "Dishes (1hr ANYTIME)"},
#           {location: "Kitchen", description: "Dishes (2 hrs any time before noon)"},
#           {location: "Kitchen", description: "Dishes (2hrs, anytime after 7pm)"},
#           {location: "Kitchen", description: "Dishes (4 - 6 pm)"},
#           {location: "Kitchen", description: "Dishes (Anytime)"},
#           {location: "???", description: "Free Pile Clean"},
#           {location: "Ito's (10s Roof)", description: "Lounge Sweep/Mop"},
#           {location: "Lead Womxns Circle", description: "???"},
#           {location: "Outer Kitchen", description: "Clean (AFTER BRUNCH)"},
#           {location: "Kitchen", description: "Pots (1hr)"},
#           {location: "Kitchen", description: "Pots (2 hrs ANYTIME BEFORE 4 pm) "},
#           {location: "Kitchen", description: "Pots (2hrs, any time after 7)"},
#           {location: "Kitchen", description: "Pots (4- 6 pm)"},
#           {location: "Red Room", description: "Surface Clean"},
#           {location: "Red Room", description: "Sweep & Mop"},
#           {location: "???", description: "Snack Shift"},
#           {location: "Waste Area", description: "Sweep"},]

# shift_details.each do |detail|
#   ShiftDetail.init(detail[:location], detail[:description])
# end
