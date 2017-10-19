class Preference < ApplicationRecord
    # belongs_to :user # would be replaced with the true user resources name
    validates :shift, :schedule, :presence => true
    validate :shift_schedule_keys
    
    @@shifts = %i{a b c} # TODO: fill this or load from file
    @@days = %i{a}
    @@times = %i{b}
    
    def shift_schedule_keys
        errors.add(:shift, "must contain all and only the shifts as keys") if shift && shift_hash.keys != @@shifts
        errors.add(:schedule, "must contain all and only the days as keys") if schedule && schedule_hash.keys != @@days
        errors.add(:schedule, "inner day hash must contain all and only the times as keys") if schedule && schedule_hash.values.inject(false) {|res, time| res = res || (time.keys != @@times)}
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
    # So call the following function to get a hash versoin of them. (e.g. in controller)
    
    def shift_hash
        eval(shift)
    end
    
    def schedule_hash
        eval(schedule)
    end
end
