class ShiftDetail < ApplicationRecord
    has_many :shift_templates
    def self.init(detail)
        new_shift_detail = ShiftDetail.new(location: detail[:location], description: detail[:description])
        return new_shift_detail.save
    end
end
