class Admin < Manager

    def self.init(username, email, password)
        return super(username, email, password, "All")
    end

end
