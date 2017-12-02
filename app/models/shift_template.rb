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

    def self.from(building)
        #FIXME
        return ShiftTemplate.all.collect
    end

    def generate
        @shift_day = Date.parse(self.day).wday
        @next_shift_date = Date.today.wday> @shift_day ? Date.parse(self.day)+7 : Date.parse(self.day)
        while @next_shift_date < Semester.current.end_date
            if self.shifts.where(date: Date.today).take == nil
                Shift.init({:user_email => self.user.email, :date => @next_shift_date, :is_checked_off => false, :shift_template_id => self.id})
            end
            @next_shift_date += 7
        end
    end

    def name
        @details ||= ShiftDetail.find(self.shift_detail_id)
        return @details.to_sym
    end

    def unique
        @details ||= ShiftDetail.find(self.shift_detail_id)
        return (@details.to_s + " " + self.specifics " : "  + self.date_time).to_sym
    end

    def specifics
        return "(" + self.details + " " + self.floor + ")"
    end

    def date_time
        return self.day + " " + self.time
    end

    def time
        return "1pm"
    end

end
