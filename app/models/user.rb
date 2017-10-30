require 'digest'
require 'openssl'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_many :preferences #, :dependencies => :destroy

    def self.init(username, email, password)
        new_user = User.new(username: username, password: password, email: email)
        return new_user.save
    end
end
