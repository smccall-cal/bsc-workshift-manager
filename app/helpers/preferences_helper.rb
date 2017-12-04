module PreferencesHelper
    include SortFilterHelper_
    
    def to_id shift
        shift.gsub((/(( & )|\/| |\(|\)|'|\+)/), "-")
    end
    
    def def_shift shift
        if @preference
            @preference.shift_hash[shift]
        else
            "0"
        end
    end
    
    def def_schedule day, time
        if @preference
            @preference.schedule_hash[day][time]
        else
            "+"
        end
    end
    
    def link_path_action params_
        if @preference
            edit_user_preference_path(@user, @preference, {:format => :js}.merge(params_))
        else
            new_user_preference_path(@user, {:format => :js}.merge(params_))
        end
    end
end
