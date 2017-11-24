class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :user_params
    before_action :manager?, only: [:new, :destroy]

    def user_params
        params.permit(:email, :username, :password, :id)
    end

    def index
        @key = params["key"] || session["key"] || "username"
        session["key"] = @key
        
        @query_ = params["query"] || session["query"] || ""
        session["query"] = @query_
        @query = Regexp.new(@query_, "i")
        
        @sort = params["sort"] || session["sort"] || ""
        if params["sort"] == session["sort"]
            session["sort"] = (@sort = "")
        else
            session["sort"] = @sort
        end
        
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
    end

    def destroy
    end

    def entry
        if user_signed_in?
            redirect_to user_path(current_user.id)
        end
    end
    
end
