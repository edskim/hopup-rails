GpsMsg::Application.routes.draw do
  resources :users, except: [ :destroy ]
  resources :topics
  resources :tags
  resources :subscriptions, only: [ :create, :destroy ]
  resources :sessions, only: [ :new, :create, :destroy ]

  root :to => 'sessions#new'
  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'
end
