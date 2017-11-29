class ShiftDetail < ApplicationRecord
    has_many :shift_templates
    def self.init(detail)
        new_shift_detail = ShiftDetail.new(location: detail[:location], description: detail[:description])
        return new_shift_detail.save
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
