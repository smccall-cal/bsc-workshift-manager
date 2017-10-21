class PreferencesController < ApplicationController
  before_action :set_user, :except => :notlogged
  before_action :set_preference, :only => [:show, :edit, :update]

  def index
    if @user.preferences.length == 0
      redirect_to no_user_preferences_path(@user)
    else
      redirect_to user_preference_path(@user, @user.preferences[0])
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
    @preference = Preference.new
  end

  # GET /preferences/1/edit
  def edit
  end

  # POST /preferences
  # POST /preferences.json
  def create
    @preference = @user.preferences.new(preference_params)
    
    respond_to do |format|
      if @preference.save
        format.html { redirect_to user_preference_path(@user, @preference), notice: 'Preference was successfully created.' }
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { render :new }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferences/1
  # PATCH/PUT /preferences/1.json
  def update
    respond_to do |format|
      if  @user.preferences.update(preference_params)
        format.html { redirect_to user_preference_path(@user, @preference), notice: 'Preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def logged_in
      session_id = params[:session_id] || session[:session_id]
      @user = User.find_by(session_id: session_id)
      session_id != nil && @user != nil
      # the following stubs for human test
      @user = User.find(params[:user_id])
      true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preference
      @preference = @user.preferences.find(params[:id])
    end
    def set_user
      @user = User.find(params[:user_id])
      if not logged_in then redirect_to notlogged_user_preferences_path(params[:user_id]) end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      {:shift=>params[:preference][:shift], :schedule=>params[:preference][:schedule]}
      # params.require(:preference).permit(:shift, :schedule) to be implemented
    end
end
