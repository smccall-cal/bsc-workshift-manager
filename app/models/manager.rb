class Manager < User

    def self.init(username, email, password, building)
        new_user = Manager.new(username: username, password: password, email: email, building: building, manage: 1)
        return new_user.save
    end
end
