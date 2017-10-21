class SemestersController < ApplicationController
    def semester_params
        params.require(:semester).permit(:semester_name, :start_date, :end_date)
    end
  
    def index
        @semesters = Semester.all
    end
    
    def create
        @semester = Semester.create!(semester_params)
        flash[:notice] = "#{@semester.semester_name} was successfully created."
        redirect_to semesters_path
    end
    
    def show
        @semester = Semester.find(params[:id])
    end
end
