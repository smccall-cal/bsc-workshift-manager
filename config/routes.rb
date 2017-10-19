Rails.application.routes.draw do
  resources :preferences, :except => [:index, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
