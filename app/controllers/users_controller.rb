class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :manager?, only: [:new, :destroy]

    def user_params
      params.permit(:email, :username, :password, :id)
    end

    def index
        if user_signed_in?
            redirect_to user_path(current_user.id)
        end
    end

    def show
        @manager = current_user.manage?
    end

    def new
        #redirect_to new_user_registration_path
    end

    def create
        valid = User.init(params[:username], params[:password])
        if !valid
            flash[:notice] = "Invalid username / password"
            redirect_to new_user_registration_path
        end
        flash[:notice] = "#{params[:username]} created successfully"
        redirect_to root_path
    end

    def edit
    end

    def update
    end

    def destroy
    end

end
