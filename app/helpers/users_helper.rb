module UsersHelper
    def selected? link
        if @sort == link then "selected" else "" end
    end
end