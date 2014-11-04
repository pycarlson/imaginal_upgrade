ImaginalUpgrade::Application.routes.draw do

  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  match 'users/sign_in' => 'static_pages#home', via: 'get'

  devise_for :users, :skip => [:registrations, :passwords], :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root :to => "static_pages#home"

  get 'profiles/:id/:name', :to => 'profiles#show'
  resources :profiles, only: [:show]

  get 'videos/:id/:name', :to => 'videos#show'
  resources :videos

  resources :categories

  get '/about' => 'static_pages#about', :as => :about
  # get '/ratings/add_rating' => 'ratings#add_rating', :as => :add_rating

  match '/add_rating' => 'ratings#add_rating', via: 'post'



end
