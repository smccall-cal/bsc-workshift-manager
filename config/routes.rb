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
        resources :shifts, :except => [:index]
    end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
