class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :manager?, only: [:new, :destroy, :index]
    before_action :set_user, only: [:edit, :update]

    def user_params
        params.require(:user).permit(:email, :username, :building)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    include SortFilter

    def index
        clear_sessions if request.format.symbol == :html # every time a manager visit this page, make it in init state
        sort_filter_params :key => "username"
        @users = User.select {|user| user[@key] =~ @query and user.role == "User" }.sort_by{|u| u[@sort]}
    end

    def show
        @manager = current_user.manage?
    end

    def new
        #redirect_to new_user_registration_path
    end

    def create
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to users_path, notice: 'User was successfully updated.'
        else
            redirect_to users_path, alert: @user.errors.full_messages[0]
        end
    end

    def destroy
    end

    def entry
        if user_signed_in?
            redirect_to user_path(current_user.id)
        end
    end
    
end
