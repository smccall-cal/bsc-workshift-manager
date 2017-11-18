class ShiftDetail < ApplicationRecord
    has_many :shift_templates
    def self.init(location, description)
        new_shift_detail = ShiftDetail.new(location: location, description: description)
        return new_shift_detail.save
    end
end
