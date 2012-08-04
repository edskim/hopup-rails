GpsMsg::Application.routes.draw do
  resources :users, except: [ :destroy ]
  resources :topics
  resources :tags
  resources :subscriptions, only: [ :index, :create, :destroy ]
  resources :sessions, only: [ :new, :create, :destroy ]

  root :to => 'sessions#new'
  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'
  match '/signout', to: 'sessions#destroy'
end
