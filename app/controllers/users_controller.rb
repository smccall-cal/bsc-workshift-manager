class UsersController < ApplicationController
    before_action :logged_in, except: [:index]
    before_action :manager, only: [:new, :destroy]

    def user_params
      params.permit(:session_id, :username, :password)
    end

    def logged_in
        session_id = params[:session_id] || session[:session_id]
        @current = User.find_by(session_id: session_id)
        return session_id != nil && @current != nil
    end

    def manager
        return @current.class == Manager
    end

    def index #Login Page
        @users = User.all()
        if logged_in
            redirect_to user_path(@current.id)
        elsif params[:username] != nil && params[:password] != nil
            if User.validate(params[:username], params[:password])
                @current = User.find_by(username: params[:username])
                session[:session_id] = @current.session_id
                redirect_to user_path(@current.id)
            else
                flash[:notice] = "Incorrect Username and / or Password"
                redirect_to users_path
            end
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
