Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'
  get '/stocks' => "stocks#create"
  get '/stocks/:ticker' => "stocks#show"


  get 'users/current/tweets' => 'tweets#tweets_for_current_user'
  get '/users/home' => "users#home"
  get '/stocks' => 'stocks#index'
  post '/stocks/:ticker/favorite' => "stocks#favorite"  
  delete '/stocks/:ticker/favorite' => "stocks#unfavorite"  
  
  resources :users, except: [:index, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :stocks, :only => [:index, :create, :update, :destroy, :favorite]

  
end
