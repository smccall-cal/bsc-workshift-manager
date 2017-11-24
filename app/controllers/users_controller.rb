class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :user_params
    before_action :manager?, only: [:new, :destroy]
    before_action :sort_filter_params, only: :index

    def user_params
        params.permit(:email, :username, :password, :id)
    end
    
    def sort_filter_params
        params.permit(:query, :key)
    end

    def index
        key = params["key"] || "username"
        query = Regexp.new((params["query"] || ".*"), "i")
        @users = User.select {|user| user[key] =~ query and user.role == "User" }
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
    end

    def destroy
    end

    def entry
        if user_signed_in?
            redirect_to user_path(current_user.id)
        end
    end
    
end
