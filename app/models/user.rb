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

    def promote(role)
        self.role = role
        self.save
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
