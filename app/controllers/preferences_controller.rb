require "json"

class PreferencesController < ApplicationController
  before_action :set_user, :except => :notlogged
  before_action :set_preference, :only => [:show, :edit, :update]

  include SortFilter

  def index
    if @user.preference.nil?
      redirect_to no_user_preferences_path(@user)
    else
      redirect_to user_preference_path(@user, @user.preference)
    end
  end

  def no
  end

  def notlogged
  end

  # GET /preferences/1
  # GET /preferences/1.json
  def show
  end

  # GET /preferences/new
  def new
    clear_sessions("rank") if request.format.symbol == :html # every time a manager visit this page, make it in init state
    sort_filter_params :key => "location"
    @shifts = Preference.shifts.select {|sh| ShiftDetail.valueOf(sh, @key) =~ @query}
    @rank = params["rank"]
  end

  # GET /preferences/1/edit
  def edit
  end

  # POST /preferences
  # POST /preferences.json
  def create
    @preference = @user.build_preference(preference_params)

    respond_to do |format|
      if @preference.save
        format.html { redirect_to user_preference_path(@user, @preference), notice: 'Preference was successfully created.' }
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { redirect_to new_user_preference_path(@user), alert: @preference.errors[:schedule][0] }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferences/1
  # PATCH/PUT /preferences/1.json
  def update

    respond_to do |format|
      if @user.preference.update(preference_params)
        format.html { redirect_to user_preference_path(@user, @preference), notice: 'Preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { redirect_to edit_user_preference_path(@user, @preference), alert: @preference.errors[:schedule][0] }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preference
      @preference = @user.preference
    end
    def set_user
      @user = current_user
      if not user_signed_in? then redirect_to notlogged_user_preferences_path(params[:user_id]) end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      {:shift=>params[:preference][:shift], :schedule=>params[:preference][:schedule]}
    end
end
