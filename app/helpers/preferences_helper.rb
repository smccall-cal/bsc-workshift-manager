module PreferencesHelper
    include SortFilterHelper_
    
    def to_id shift
        shift.gsub((/(( & )|\/| |\(|\)|'|\+)/), "-")
    end
end
