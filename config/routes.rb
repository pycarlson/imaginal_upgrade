ImaginalUpgrade::Application.routes.draw do
  
  devise_for :users
  root :to => "static_pages#home"
  
  resources :profiles, only: [:show]
  resources :videos 
  resources :categories

  get '/about' => 'static_pages#about', :as => :about
  # get '/ratings/add_rating' => 'ratings#add_rating', :as => :add_rating

  match '/add_rating' => 'ratings#add_rating', via: 'get'

end
