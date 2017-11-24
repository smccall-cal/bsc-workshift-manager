module UsersHelper
    def selected? link, var
        if var == link then "selected" else "" end
    end
end