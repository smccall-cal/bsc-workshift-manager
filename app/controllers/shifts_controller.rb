class ShiftsController < ApplicationController
  before_action :manager?, except: [:sign_off, :complete_sign_off]
  before_action :set_semester, except: [:sign_off, :complete_sign_off]
  before_action :set_shift, except: [:index, :sign_off, :complete_sign_off]

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Array.new
    @semester.shift_templates.each{
      |template| template.shifts.each{
        |shift| @shifts.push(shift)
      }
    }
  end

  # GET /semesters/:semester_id/shifts/:id(.:format)
  # GET /shifts/1.json
  def show

  end

  include SortFilter

  def sign_off
    clear_sessions if request.format.symbol == :html
    get_filter

    @users = User.all.map{ |user| [user.username, user.id] }.delete_if{ |name, id| id == @filter.to_i }

    if user_signed_in?
        @verifiers = [[current_user.username, current_user.id]]
        @size = 19
    else
        @verifiers = @users
        @size = 6
    end

    @shifts = Shift.where(:date => (Date.today - 4)..(Date.today + 3))
    @shifts = @shifts.to_a.delete_if{ |shift| shift.is_checked_off || shift.user_id != @filter.to_i}.map{ |shift| [shift.unique, shift.id]}
  end

  def complete_sign_off
      verifier = User.find params[:verifier]
      if !user_signed_in? && !verifier.valid_password?(params[:password])
          flash[:notice] = "Incorrect password!"
          return redirect_to sign_off_path
      end

      shift = Shift.find params[:shift]
      if shift.user_id.to_i != params[:workshifter].to_i
          flash[:notice] = "This shift doesn't belong to this resident!"
          return redirect_to sign_off_path
      end

      shift.is_checked_off = true
      shift.checked_off_by = verifier.id
      shift.save

      redirect_to root_path
  end

# GET /semesters/:semester_id/shifts/new(.:format)
#  def new
#    @shift_template = ShiftTemplate.new
#    @shift_detail = ShiftDetail.new
#    @semester = Semester.find(session[:semester]["id"])
#  end

  # GET /semesters/:semester_id/shifts/:id/edit(.:format)
  def edit
    @users = User.all.collect{ |u| [u.username] }
  end

# POST /semesters/:semester_id/shifts(.:format)
# POST /shifts.json
#  def create
#    @semester = Semester.find(session[:semester]["id"])

#    @shift_detail = ShiftDetail.find_by_location_and_description(params[:shift_detail][:location],params[:shift_detail][:description])
#    @shift_template = @shift_detail.shift_templates.create(shift_params)
#    @shift_template.semesters << @semester
#    redirect_to semester_path(@semester)

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
 # end

  # PATCH/PUT /semesters/:semester_id/shifts/:id(.:format)
  # PATCH/PUT /semesters/:semester_id/shifts/:id(.:format)
  def update
    @shift.update_attributes(:is_checked_off => shift_params[:is_checked_off] == "Yes", :date => Date.new(shift_params["date(1i)"].to_i, shift_params["date(2i)"].to_i, shift_params["date(3i)"].to_i))
    @user = User.where(:username => shift_params[:user_id]).first
    @shift.user = @user
    @shift.save
    redirect_to semester_shifts_path(@semester)
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
    @semester = Semester.find(session[:semester]["id"])
    @shift = Shift.find params[:id]
    @shift.destroy
    redirect_to semester_path(@semester)
    # respond_to do |format|
    #   format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def add_new_shift_user
    @shift = Shift.find params[:id]
    @user = User.where(:email => params[:shift][:users]).first
    @shift.users << @user
    redirect_to(semester_shift_path(@shift))
  end

  def delete_new_shift_user
    @shift = Shift.find params[:id]
    @user = User.find params[:user_id]
    @shift.users.destroy(@user)
    redirect_to(semester_shift_path(@shift))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_semester
      @semester = Semester.find(params[:semester_id])
    end

    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:is_checked_off,:user_id,:date)
    end

    def shift_template_params
      params.require(:shift_template).permit(:description, :location, :semester)
    end

    def shift_detail_params
      params.require(:shift_detail).permit(:description, :location)
    end
end
