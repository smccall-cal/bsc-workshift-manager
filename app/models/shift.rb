class Shift < ApplicationRecord
    belongs_to :semester
    has_and_belongs_to_many :users

    def to_s
        return shift.time + " " + shift.name + " " + shift.location
    end
end
