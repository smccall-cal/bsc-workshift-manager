class PreferencesController < ApplicationController
  before_action :set_preference, only: [:show, :edit, :update]

  def no
    flash[:notice] = "No preferences."
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
    @preference = Preference.new(preference_params)
    
    respond_to do |format|
      if @preference.save
        format.html { redirect_to @preference, notice: 'Preference was successfully created.' }
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
      if @preference.update(preference_params)
        format.html { redirect_to @preference, notice: 'Preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preference
      @preference = Preference.find(params[:id])
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      {:shift=>params[:preference][:shift], :schedule=>params[:preference][:schedule]}
      # params.require(:preference).permit(:shift, :schedule)
    end
end
