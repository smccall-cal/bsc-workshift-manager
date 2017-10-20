require 'digest'

class User < ActiveRecord::Base
    has_many :preferences

    def self.init(username, password)
        hashed_pass = Digest::SHA256.hexdigest password
        valid = User.create(username: username, hashed_pass: hashed_pass)
        return valid != nil
    end

    def self.validate(username, password)
        hashed_pass = Digest::SHA256.hexdigest password
        user = User.find_by(username: username)

        if user == nil
            return false
        elsif user.hashed_pass != hashed_pass
            return false
        end

        return true
    end
end
