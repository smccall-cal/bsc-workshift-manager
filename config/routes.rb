Rails.application.routes.draw do
  resources :preferences, :except => [:index, :destroy] do
    collection do
      get "/no" , :to => "preferences#no", :as => "no"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
