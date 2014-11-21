ImaginalUpgrade::Application.routes.draw do

  ActiveAdmin.routes(self)

  match 'users/sign_in' => 'pages#home', via: 'get'

  devise_for :users, :skip => [:registrations, :passwords], :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root :to => "pages#home"

  get 'profiles/:id/:name', :to => 'profiles#show'
  resources :profiles, only: [:show]

  get 'videos/:id/:name', :to => 'videos#show'
  put 'videos/:id/:name', :to => 'videos#update'
  post 'videos/:id', :to => 'videos#destroy'
  post 'videos/:id/:name', :to => 'videos#destroy'
  resources :videos

  resources :categories
  resources :tags

  match '/add_rating' => 'ratings#add_rating', via: 'post'

  match '/set_preference' => 'preferences#set_preference', via: 'post'

  get '/:id', to: 'pages#show'

end
