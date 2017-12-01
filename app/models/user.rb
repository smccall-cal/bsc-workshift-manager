require 'digest'
require 'openssl'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_one :preference, :dependent => :destroy
    has_many :shifts, :dependent => :destroy
    has_many :shift_templates, :dependent => :destroy
    has_many :market


    def self.init(username, email, password, building)
        new_user = User.new(username: username, password: password, email: email, building: building)
        return new_user.save
    end

    def self.from(building)
        return User.where(:building == building)
    end

    def current_shifts
        all = self.shifts
        return all.select{ |shift| shift.shift_template == Semester.current }
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

    def preference_for shift_name, shift_time
        return self.preference.shift_hash[shift_name] * self.preference.availability(shift_time)
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
