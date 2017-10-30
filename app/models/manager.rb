class Manager < User

    def self.init(username, email, password)
        new_user = Manager.new(username: username, password: password, email: email, manage: 1)
        return new_user.save
    end
end
