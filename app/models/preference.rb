class Preference < ApplicationRecord
    # belongs_to :user # would be replaced with the true user resources name
    validates :shift, :schedule, :presence => true
    validate :shift_schedule_keys
    
    @@shifts = []
    
    # temporarily use file to load shift names
    
    File.open("app/models/shifts", "r") do |f|
      f.each_line do |line|
        @@shifts.push(line.to_sym)
      end
    end
    
    # TODO: change shifts source to api from another rescource Shift
    
    @@days = %i{Monday Tueday Wednesday Thursday Friday Saturday Sunday}
    @@times = (8..23).map {|t| "#{t%12}#{(t < 12)? 'am' : 'pm' }"}
    
    def shift_schedule_keys
        errors.add(:shift, "must contain all and only the shifts as keys") if shift && shift_hash.keys != @@shifts
        errors.add(:schedule, "must contain all and only the days as keys") if schedule && schedule_hash.keys != @@days
        errors.add(:schedule, "inner day hash must contain all and only the times as keys") if schedule && schedule_hash.values.inject(false) {|res, time| res = res || (time.keys != @@times)}
        p errors
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
        eval(shift).symbolize_keys
    end
    
    def schedule_hash
        eval(schedule).symbolize_keys
    end
end
