class RegistrationsController < Devise::RegistrationsController
    
    skip_before_action :new_password, :only => [:edit, :update]
    
    
    def update
        u = User.find(current_user.id)
        u.init = false
        u.save
        super
    end
    
    protected
        def after_update_path_for(resource)
            new_user_preference_path(current_user.id)
        end
end