class Shift < ApplicationRecord
    belongs_to :semester
    has_and_belongs_to_many :users
end
