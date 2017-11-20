class Shift < ApplicationRecord

    belongs_to :user
    belongs_to :shift_template

    def self.init(shift)
        user = User.where(email: shift[:user_email]).take
        user.shifts.create!(date: shift[:date], is_checked_off: shift[:is_checked_off], shift_template_id: shift[:shift_template_id])
    end

    def to_s
        return shift.time + " " + shift.name + " " + shift.location
    end
end
