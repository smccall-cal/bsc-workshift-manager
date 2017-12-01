class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :manager?, only: [:new, :create, :destroy, :revoke, :index]
    skip_before_action :require_no_authentication
    skip_before_action :new_password, :only => [:edit, :update]


    def update
        u = User.find(current_user.id)
        u.init = false
        u.save
        super
    end

    def mass_new
    end

    def mass_create
        redirect_url = params[:user][:redirect] # It may be from users/massnew or /users
        names = params[:user][:username].split /\r?\n/
        emails = params[:user][:email].split /\r?\n/
        building = params[:user][:building]
        pairs = Hash[names.zip emails]

        #Split names and emails by regex, save to hash pairs {name => email}
        pairs.each{|name, email|
            User.init(name, email, "5108481936", building)
        }
        redirect_to redirect_url
    end

    def delete
        @users = User.all.select {|user| user.role == "User"}
    end

    def revoke
        User.find(params[:id]).destroy
        redirect_to users_path
    end

    def configure_sign_up_params
       devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :building])
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    def sign_up(resource_name, resource)
    end

    #The path used after sign up.
    def after_sign_up_path_for(resource)
       user_path(current_user.id)
    end

    protected
        def after_update_path_for(resource)
            new_user_preference_path(current_user.id)
        end
end
