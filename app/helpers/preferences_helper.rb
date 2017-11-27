require "json"

module PreferencesHelper
    include SortFilterHelper_
    
    def to_id shift
        shift.gsub((/(( & )|\/| )/), "-").gsub(/(\()|(\))|'|\+/, "-")
    end
end
