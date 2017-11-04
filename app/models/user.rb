require 'digest'
require 'openssl'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_many :preferences #, :dependencies => :destroy
    has_and_belongs_to_many :shifts

    def self.init(username, email, password)
        new_user = User.new(username: username, password: password, email: email, manage: 0)
        return new_user.save
    end

    def manage?
        return manage == 1
    end
end
