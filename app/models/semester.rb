class Semester < ApplicationRecord
    has_and_belongs_to_many :shift_templates, dependent: :destroy
    
    def self.init(semester_name, start_date, end_date)
        new_semester = Semester.new(semester_name: semester_name, start_date: start_date, end_date: end_date)
        return new_semester.save
    end
end
