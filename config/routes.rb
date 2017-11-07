Rails.application.routes.draw do

    devise_for :users, :controllers => { :registrations => :registrations }

    root :to => "users#index"
    #FIXME with proper controller path

    resources :users do
        resources :preferences, :except => [:destroy] do
            collection do
              get "/none" , :to => "preferences#no", :as => "no"
              get "/notlogged", :to => "preferences#notlogged", :as => "notlogged"
            end
        end
    end

    resources :semesters do
        resources :shifts, :except => [:index] do
            collection do
              post "/:id/addshiftuser" , :to => "shifts#add_new_shift_user", :as => "add_user"
              delete ":id/user/:user_id" , :to => "shifts#delete_new_shift_user", :as => "delete_shift_user"
            end
        end
    end


    #resources :shifts_users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
