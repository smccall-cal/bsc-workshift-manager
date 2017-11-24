class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :user_params
    before_action :manager?, only: [:new, :destroy, :index]
    skip_before_action :verify_authenticity_token, if: :sort_filter?
    
    def sort_filter?
        action_name == "index" && request.format.symbol == :js
    end

    def user_params
        params.permit(:email, :username, :password, :id)
    end

    def clear_sessions
        session["key"] = nil
        session["query"] = nil
        session["sort"] = nil
    end
    
    def index_params
        get_key
        get_query
        get_sort
    end
    
    def get_key
        @key = params["key"] || session["key"] || "username"
        session["key"] = @key
    end
    
    def get_query
        @query_ = params["query"] || session["query"] || ""
        session["query"] = @query_
        @query = Regexp.new(@query_, "i")
    end
    
    def get_sort
        @sort = params["sort"] || session["sort"] || ""
        if params["sort"] == session["sort"] # click on the same link second time to disable sorting
            session["sort"] = (@sort = "")
        else
            session["sort"] = @sort
        end
    end
    

    def index
        clear_sessions if request.format.symbol == :html # every time a manager visit this page, make it in init state
        index_params
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
