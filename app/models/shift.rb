class Shift < ApplicationRecord
    has_one :user
    has_one :shift_template
    
    def self.init(date, user_email, shift_templates_id, is_checked_off = false)
        user = User.where(email: user_email).take
        user.shifts.create!(date: date, is_checked_off: is_checked_off, shift_templates_id: shift_templates_id)
    end
end
