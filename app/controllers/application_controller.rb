class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_password, :unless => :log_out

  def home
  end

  def new_password
      if current_user && current_user.init
          redirect_to edit_user_registration_path
      end
  end

  def admin?
      if not (user_signed_in? && current_user.admin?) then redirect_to root_path end
  end

  def manager?
      if not (user_signed_in? && current_user.manage?) then redirect_to root_path end
  end

  def log_out # log_out routed to sessions#destroy
      controller_name == "sessions" and action_name == "destroy"
  end

end
