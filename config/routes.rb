Rails.application.routes.draw do

    root :to => "users#index"
    #FIXME with proper controller path

    resources :users do
        resources :preferences, :except => [:index, :destroy]
        get "preferences/none" , :to => "preferences#no", :as => "no_preferences"
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
