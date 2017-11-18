class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :manager?, only: [:new, :create, :destroy]
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
        names = params[:names]
        emails = params[:emails]
        building = params[:building]

        #Split names and emails by regex, save to hash pairs {name => email}
        pairs.each{|name, email|
            User.init(username: name, email: email, password: "5108481936", building: building)
        }
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
       users_path
    end

    protected
        def after_update_path_for(resource)
            new_user_preference_path(current_user.id)
        end
end
