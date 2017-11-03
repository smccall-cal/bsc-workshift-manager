class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
  end

  def manager?
      if not (user_signed_in? && current_user.manage?) then redirect_to root_path end
  end

end
