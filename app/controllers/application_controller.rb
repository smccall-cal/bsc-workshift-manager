class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_password

  def home
  end
  
  def new_password
      if current_user && current_user.init
          redirect_to edit_user_registration_path
      end
  end

end
