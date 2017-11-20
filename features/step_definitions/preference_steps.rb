require 'digest'

Given /^user "(.*)" has set up preferences/ do |username|
    seed = Digest::SHA256.hexdigest(username).to_i(32)
    prng = Random.new seed
    # The randomly generated numbers will be the same for each trial,
    # but unique to each user

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
