class SemestersController < ApplicationController
  before_action :manager?
  before_action :set_semester, only: [:show, :edit, :update, :destroy]

  # GET /semesters
  # GET /semesters.json
  def index
    @semesters = Semester.all
  end

  # GET /semesters/1
  # GET /semesters/1.json
  def show
      session[:semester] = @semester
      @shift_templates = @semester.shift_templates.all
  end

  # GET /semesters/new
  def new
    @semester = Semester.new
  end

  # GET /semesters/1/edit
  def edit
  end

  # POST /semesters
  # POST /semesters.json
  def create
      @semester = Semester.create!(semester_params)
      flash[:notice] = "#{@semester.semester_name} was successfully created."
      redirect_to semesters_path
  end

  def generate
    @semester = Semester.find(params[:semester_id])
    @shift_templates = @semester.shift_templates
    @shift_templates.each{|template| template.generate}
    redirect_to semester_path(@semester)
  end

  def default
      if current_user.admin?
          flash[:notice] = "Sorry, this functionality is building-specific"
          redirect_to user_path current_user.id
      end

      default = Matcher.new current_user.building
      matches = default.match

      if !Semester.find(params[:semester_id]).assign(matches)
          flash[:notice] = "Something went wrong, please try again"
      end

      redirect_to semester_shifts_path params[:semester_id]
  end

  # def create
  #   @semester = Semester.new(semester_params)

  #   respond_to do |format|
  #     if @semester.save
  #       format.html { redirect_to @semester, notice: 'Semester was successfully created.' }
  #       format.json { render :show, status: :created, location: @semester }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @semester.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /semesters/1
  # PATCH/PUT /semesters/1.json
  def update
    if @semester.update(semester_params)
        redirect_to semester_path(@semester), notice: 'Semester was successfully updated.'
    else
        redirect_to semesters_path, alert: @semester.errors.full_messages[0]
    end
  end

  # DELETE /semesters/1
  # DELETE /semesters/1.json
  def destroy
    @semester.destroy
    redirect_to semesters_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_semester
      @semester = Semester.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def semester_params
    #   params.fetch(:semester, {})
    # end

    def semester_params
      params.require(:semester).permit(:semester_name, :start_date, :end_date)
  end
end
