require 'digest'
require 'openssl'

class User < ActiveRecord::Base
    validates :username, :hashed_pass, :presence => true

    has_many :preferences #, :dependencies => :destroy
    @@cipher = OpenSSL::Cipher::AES.new(256, :CFB) #Will implement encryption for sensitive data

    def self.init(username, password)
        hashed_pass = Digest::SHA256.hexdigest password
        id = User.new_session_id
        valid = User.create(username: username, hashed_pass: hashed_pass, session_id: id)
        return valid != nil
    end

    def self.validate(username, password)
        hashed_pass = Digest::SHA256.hexdigest password
        user = User.find_by(username: username)

        if user == nil || user.hashed_pass != hashed_pass
            return false
        end

        return true
    end

    def self.new_session_id
        id = rand(2**16)
        while User.find_by(session_id: id) != nil
            id = rand(2**16)
        end
        return id
    end
end
