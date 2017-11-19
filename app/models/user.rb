require 'digest'
require 'openssl'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_many :preferences #, :dependencies => :destroy
    has_and_belongs_to_many :shifts

    def self.init(username, email, password, building)
        new_user = User.new(username: username, password: password, email: email, building: building)
        return new_user.save
    end

    def current_shifts
        return []
        #all = self.shifts
        #return all.select{ |shift| shift.shift_template == Semester.current }
    end

    def promote role
        self.role = role
        self.save
        return self
    end

    def unset_init
        self.init = false
        self.save
        return self
    end

    def preference_for shift_name
        return self.preference.shift_hash[shift_name]
    end

    def manage?
        return self.role == "Manager" || admin?
    end

    def admin?
        return self.role == "Admin" || president?
    end

    def president?
        return self.role == "President"
    end

    def buildings
        if self.admin?
            return ["Afro", "Castro", "CZ", "Cloyne", "Convent", "Davis", "Euclid",
                    "Fenwick", "Hillegass-Parker", "Hoyt", "Kidd", "Kingman", "Lothlorien",
                    "Northside", "Ridge", "Rochdale", "Sherman", "Stebbins", "Wilde", "Wolf"]
        end
        return [self.building]
    end
end
