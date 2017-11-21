class Preference < ApplicationRecord
    belongs_to :user
    validates :shift, :schedule, :presence => true
    validate :shift_schedule_keys
    validate :available_time_more_than_5

    @@shifts = ShiftDetail.all.map {|sh| (sh.location + "--" + sh.description).to_sym}

    @@days = %i{Monday Tueday Wednesday Thursday Friday Saturday Sunday}
    @@times = (8..23).map {|t| "#{t%12}#{(t < 12)? 'am' : 'pm' }"}

    def shift_schedule_keys
        check_shift_keys
        check_schedule_day_keys
        check_schedule_time_keys
    end
    
    def check_shift_keys
        errors.add(:shift, "must contain all and only the shifts as keys") if shift && shift_hash.keys != @@shifts
    end
    def check_schedule_day_keys
        errors.add(:schedule, "must contain all and only the days as keys") if schedule && schedule_hash.keys != @@days
    end
    def check_schedule_time_keys
        errors.add(:schedule, "inner day hash must contain all and only the times as keys") if schedule && schedule_hash.values.inject(false) {|res, time| res = res || (time.keys != @@times)}
    end
    
    def available_time_more_than_5
        errors.add(:schedule, "Available time should be at least 5 hours.") if schedule && (schedule_hash.values.inject(0) {|coun, d| coun+=d.values.count("+")}) < 5
    end

    def self.shifts
        @@shifts
    end

    def self.days
        @@days
    end

    def self.times
        @@times
    end

    # When setting colomns, rails stringifies hash automatically.
    # So call the following function to get a hash version of them. (e.g. in controller)

    def shift_hash
        eval(shift).symbolize_keys
    end

    def schedule_hash
        eval(schedule).symbolize_keys
    end
end
