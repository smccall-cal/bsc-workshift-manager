Given /^user "(.*)" has set up preferences/ do |username|
    prng = Random.new 302311032839596222952479417808629865936 # Make the randomly generated numbers the same every time you test.
    # You can remove the seed (just write Random.new) if you think make it different every time you test makes more sense.
    
    shifts = Preference.shifts.map {|a| a.to_s}
    shift = Hash[shifts.zip shifts.map {prng.rand 1..5}]
    
    availabilities = ["+", "-", "x", "?"]
    days = Preference.days.map {|a| a.to_s}
    times_ = Preference.times
    schedule = {}
    days.each do |d|
        schedule[d] = Hash[times_.zip times_.map {availabilities[prng.rand availabilities.length]}]
    end
    
    user = User.find_by_username username
    user.build_preference(:shift => shift, :schedule => schedule).save
end