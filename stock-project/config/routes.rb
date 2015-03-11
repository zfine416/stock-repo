Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'

  get 'users/current/tweets' => 'tweets#tweets_for_current_user'
  get '/users/home' => "users#home"
  resources :users, except: [:index, :show]
  resource :session, only: [:new, :create, :destroy]

  
end
