class PoliciesController < ApplicationController
  before_action :authenticate_user!
  before_action :manager?, except: :download
  before_action :set_policy, only: [:show, :edit, :update, :destroy, :download]

  def upload_file
    @policy_io = policy_params
    File.open(Rails.root.join('public', 'uploads', @policy_io.original_filename), 'wb') do |file|
      file_ = File.open(@policy_io.path, 'r')
      file.write(file_.read)
      file.close
    end
  end
  
  def delete_file
    full_filename = Rails.root.join('public', 'uploads', @policy.filename)
    p File.exist? full_filename
    File.delete(full_filename) if File.exist? full_filename
  end

  # GET /policies
  # GET /policies.json
  def index
    if Policy.all.empty?
      redirect_to new_policy_path
    else
      redirect_to policy_path(Policy.first)
    end
  end

  # GET /policies/1
  # GET /policies/1.json
  def show
  end

  # GET /policies/new
  def new
    unless Policy.all.empty?
      redirect_to policy_path(Policy.first)
    end
    @policy = Policy.new
  end

  # GET /policies/1/edit
  def edit
  end

  # POST /policies
  # POST /policies.json
  def create
    upload_file
    @policy = Policy.new(:filename => @policy_io.original_filename)

    respond_to do |format|
      if @policy.save
        format.html { redirect_to @policy, notice: 'Policy was successfully created.' }
        # format.json { render :show, status: :created, location: @policy }
      else
        format.html { render :new }
        # format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /policies/1
  # PATCH/PUT /policies/1.json
  def update
    delete_file
    upload_file
    respond_to do |format|
      if @policy.update(:filename => @policy_io.original_filename)
        format.html { redirect_to @policy, notice: 'Policy was successfully updated.' }
        # format.json { render :show, status: :ok, location: @policy }
      else
        format.html { render :edit }
        # format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policies/1
  # DELETE /policies/1.json
  def destroy
    delete_file
    @policy.destroy
    respond_to do |format|
      format.html { redirect_to policies_url, notice: 'Policy was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end
  
  def download
    send_file(
      Rails.root.join('public', 'uploads', @policy.filename),
      filename: @policy.filename,
      type: "text/plain",
      disposition: 'attachment'
    )
  end
  
  def set_policy
    @policy = Policy.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def policy_params
    params[:policy][:policy_file]
  end
  
end
