class UserController < ApplicationController
    before_action :logged_in, :except[:index]

    def user_params
      params.permit(:session_id, :username, :password)
    end

    def logged_in
        session_id = params[:session_id] || session[:session_id]
        @current = User.find_by(session_id: session_id)
        return session_id != nil && @current != nil
    end

    def index #Login Page
        if logged_in
            @current.id
            redirect_to user_path(id)
        end
    end

    def show
    end

    def new
    end

    def create
        valid = User.init(params[:username], params[:password])
        if !valid
            flash[:notice] = "Invalid username / password"
            redirect_to new_user_path
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
