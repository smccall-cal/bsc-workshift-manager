class Semester < ApplicationRecord
    has_and_belongs_to_many :shift_templates, dependent: :destroy

    def self.init(semester)
        new_semester = Semester.new(semester_name: semester[:semester_name], start_date: semester[:start_date], end_date: semester[:end_date])
        return new_semester.save
    end

    def assign matches
        success = true
        matches.each{ |user, shifts|
            shifts.each { |name|
                shift = ShiftTemplate.find_by(name: name)
                shift.user_id = user
                success &= shift.save
            }
        }
        return success
    end
end
