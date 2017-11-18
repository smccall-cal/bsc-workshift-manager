class ShiftTemplate < ApplicationRecord
    has_and_belongs_to_many :semester
    has_many :shifts
    has_one :shift_detail
    
    def self.init(location, description, hours, day, floor = nil, details = nil)
        shift_detail = ShiftDetail.where(location: location, description: description).take
        shift_detail.shift_templates.create!(hours: hours, day: day, floor: floor, details: details)
    end
end
