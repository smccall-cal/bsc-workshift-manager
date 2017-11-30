class Market < ActiveRecord::Base
  # has_many :user
  belongs_to :user,optional: true
end
