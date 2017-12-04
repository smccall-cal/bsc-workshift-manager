Rails.application.routes.draw do
    
    devise_for :users, :controllers => { :registrations => :registrations }
    devise_scope :user do
        get "/users/delete" => "registrations#delete", :as => "delete"
        get "/users/massnew" => "registrations#mass_new", :as => "mass_add"
        post "/users/masscreate" => "registrations#mass_create", :as => "mass_create"
        delete "/users/:id/revoke" => "registrations#revoke", :as => "revoke"
        get "/users/entry" => "users#entry", :as => "entry"
    end

    root :to => "users#entry"

    resources :users do
        resources :preferences, :except => [:destroy] do
            collection do
              get "/none" , :to => "preferences#no", :as => "no"
            end
        end
        resources :markets

    end

    resources :semesters do
        post "/generate" , :to => "semesters#generate", :as => "generate_shifts"
        resources :shifts do
            collection do

              post "/:id/addshiftuser" , :to => "shifts#add_new_shift_user", :as => "add_user"
              delete ":id/user/:user_id" , :to => "shifts#delete_new_shift_user", :as => "delete_shift_user"
            end
        end
        post "/default", :to => "semesters#default", :as => "default_assignment"

        resources :shift_templates, :except => [:index]
    end
    
    resources :policies do
        member do
            get "/download", :to => "policies#download", :as => "download"
        end
    end

    get "/signoff", :to => "shifts#sign_off", :as => "sign_off"
    post "/signoff", :to => "shifts#complete_sign_off", :as => "complete_sign_off"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
