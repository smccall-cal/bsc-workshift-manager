class Preference < ApplicationRecord
    belongs_to :user # would be replaced with the true user resources name
    # TODO: when find and save, use json or yaml serialization
end
