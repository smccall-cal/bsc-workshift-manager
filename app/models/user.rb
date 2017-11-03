require 'digest'
require 'openssl'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_many :preferences #, :dependencies => :destroy

    def self.init(username, email, password, building)
        new_user = User.new(username: username, password: password, email: email, building: building, manage: 0)
        return new_user.save
    end

    def manage?
        return manage == 1
    end

    def buildings
        if self.building == "All"
            return ["Afro", "Castro", "CZ", "Cloyne", "Convent", "Davis", "Euclid",
                    "Fenwick", "Hillegass-Parker", "Hoyt", "Kidd", "Kingman", "Lothlorien",
                    "Northside", "Ridge", "Rochdale", "Sherman", "Stebbins", "Wilde", "Wolf"]
        end
        return [self.building]
    end
end
