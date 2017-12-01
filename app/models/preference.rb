class Preference < ApplicationRecord
    belongs_to :user
    validates :shift, :schedule, :presence => true
    validate :shift_schedule_keys
    validate :available_time_more_than_5

    @@shifts = []
    @@days = []
    @@times = []

    def shift_schedule_keys
        check_shift_keys
        check_schedule_day_keys
        check_schedule_time_keys
    end

    def check_shift_keys
        errors.add(:shift, "must contain all and only the shifts as keys") if shift && shift_hash.keys != Preference.shifts
    end
    def check_schedule_day_keys
        errors.add(:schedule, "must contain all and only the days as keys") if schedule && schedule_hash.keys != Preference.days
    end
    def check_schedule_time_keys
        errors.add(:schedule, "inner day hash must contain all and only the times as keys") if schedule && schedule_hash.values.inject(false) {|res, time| res = res || (time.keys != Preference.times)}
    end

    def available_time_more_than_5
        errors.add(:schedule, "Available time should be at least 5 hours.") if schedule && (schedule_hash.values.inject(0) {|coun, d| coun+=d.values.count("+")}) < 5
    end

    def self.shifts
        @@shifts = ShiftDetail.all.map {|sh| sh.to_sym}
    end

    def self.days
        @@days = %i{Monday Tueday Wednesday Thursday Friday Saturday Sunday}
    end

    def self.times
        @@times = (8..23).map {|t| "#{ (t-1) % 12 + 1 }#{(t < 12)? 'am' : 'pm' }"}
    end

    # When setting colomns, rails stringifies hash automatically.
    # So call the following function to get a hash version of them. (e.g. in controller)

    def shift_hash
        eval(shift).symbolize_keys
    end

    def schedule_hash
        eval(schedule).symbolize_keys
    end

    def availability time
        translate = {"X" => 0, "+" => 1, "-" => 0.5, "?" => 0.5}
        return translate[self.schedule_hash[time]]
    end
end
