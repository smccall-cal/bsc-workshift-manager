class Semester < ApplicationRecord
    has_many :shifts, dependent: :destroy
end
