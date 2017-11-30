class ShiftDetail < ApplicationRecord
    has_many :shift_templates
    def self.init(detail)
        new_shift_detail = ShiftDetail.new(location: detail[:location], description: detail[:description])
        return new_shift_detail.save
    end
    
    def self.find_by_location_and_description(location, description)
        shift_detail = ShiftDetail.where(location: location,description: description).take
        if shift_detail.nil?
            shift_detail = ShiftDetail.new(location: location,description: description)
            shift_detail.save
        end
        shift_detail
    end
    
    def self.check_and_remove_hanging_details(shift_detail)
        if(shift_detail.shift_templates.count == 0)
            shift_detail.delete
        end
    end
end
