class ShiftDetail < ApplicationRecord
    has_many :shift_templates
    def self.init(detail)
        new_shift_detail = ShiftDetail.new(location: detail[:location], description: detail[:description])
        return new_shift_detail.save
    end

    def self.find_by_location_and_description(location, description)
        shift_detail = ShiftDetail.where(location: location, description: description).take
        if shift_detail.nil?
            shift_detail = ShiftDetail.new(location: location, description: description)
            shift_detail.save
        end
        shift_detail
    end

    def self.check_and_remove_hanging_details(shift_detail)
        if(shift_detail.shift_templates.count == 0)
            shift_detail.delete
        end
    end

    def to_s
        self.location + "--" + self.description
    end

    def to_s_with_space
        self.location + " -- " + self.description
    end

    def to_sym
        self.to_s.to_sym
    end

    def self.valueOf s, key # retrieve a value of the given key from a ShiftDetail which has been converted into String or Symbol
        s = s.to_s if s.instance_of? Symbol
        if key == "location"
            s[0..(s.index("--") - 1)]
        elsif key == "description"
            s[(s.index("--") + 2)..(s.length - 1)]
        else
            ""
        end
    end
end
