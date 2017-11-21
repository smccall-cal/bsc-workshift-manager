class ShiftTemplate < ApplicationRecord
    has_and_belongs_to_many :semesters
    has_many :shifts
    belongs_to :shift_detail
    belongs_to :user, optional: true
    
    def self.init(template)
        shift_detail = ShiftDetail.where(location: template[:location], description: template[:description]).take
        @shift_template = shift_detail.shift_templates.create!(hours: template[:hours], day: template[:day], floor: template[:floor], details: template[:details], user_id: template[:user_id])
        @shift_template.semesters << Semester.find(template[:semester_id])
    end
end

