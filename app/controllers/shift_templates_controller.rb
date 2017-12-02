class ShiftTemplatesController < ApplicationController
  before_action :manager?
  before_action :set_shift_template, only: [:show, :edit, :update, :destroy]
  before_action :set_semester, only: [:show, :edit, :update, :destroy,:new, :create]

  # GET /shifts
  # GET /shifts.json
  # def index
  #   @shifts = Shift.all
  # end

  # GET /semesters/:semester_id/shifts/:id(.:format) 
  # GET /shifts/1.json
  def show
  end

  # GET /semesters/:semester_id/shifts/new(.:format)
  def new
    @users = User.all.collect{ |u| [u.username] }
  end

  # GET /semesters/:semester_id/shifts/:id/edit(.:format)
  def edit
    @users = User.all.collect{ |u| [u.username] }
    @shift_detail = @shift_template.shift_detail
  end

  # POST /semesters/:semester_id/shifts(.:format) 
  # POST /shifts.json
  def create
    @shift_detail = ShiftDetail.find_by_location_and_description(params[:shift_detail][:location],params[:shift_detail][:description])
    @shift_template = @shift_detail.shift_templates.create(shift_template_params)
    @user = User.where(username: params[:shift_template][:assigned_user]).take
    @shift_template.user = @user
    @shift_template.semesters << @semester
    @shift_template.save
    redirect_to semester_path(@semester)
    
    # @shift = Shift.new(shift_params)

    # respond_to do |format|
    #   if @shift.save
    #     format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
    #     format.json { render :show, status: :created, location: @shift }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @shift.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /semesters/:semester_id/shifts/:id(.:format)
  # PATCH/PUT /semesters/:semester_id/shifts/:id(.:format)
  def update
    @shift_detail = ShiftDetail.find_by_location_and_description(params[:shift_detail][:location],params[:shift_detail][:description])
    if (!@shift_template.shift_detail.eql?@shift_detail)
      @temp_shift_detail = @shift_template.shift_detail
      @shift_template.shift_detail = @shift_detail
      @shift_template.save
      ShiftDetail.check_and_remove_hanging_details(@temp_shift_detail)
    end
    @user = User.where(username: params[:shift_template][:assigned_user]).take
    @shift_template.user = @user
    @shift_template.update_attributes!(shift_template_params)
    redirect_to semester_path(@semester)
  end
  # def update
  #   respond_to do |format|
  #     if @shift.update(shift_params)
  #       format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @shift }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @shift.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /semesters/:semester_id/shifts/:id(.:format)
  # DELETE /shifts/1.json
  def destroy
    @shift_template.shifts.each {|s| s.destroy}
    @shift_template.destroy
    redirect_to semester_path(@semester)
    # respond_to do |format|
    #   format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift_template
      @shift_template = ShiftTemplate.find(params[:id])
    end
    
    def set_semester
      @semester = Semester.find(params[:semester_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_template_params
      params.require(:shift_template).permit(:day,:hours,:floor,:details)
    end
    
    def shift_detail_params
      params.require(:shift_detail).permit(:description, :location)
    end
end
