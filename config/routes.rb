GpsMsg::Application.routes.draw do
  resources :users
  resources :topics
  resources :tags
  resources :subscriptions, except: [ :show, :edit, :update ]

  root :to => 'sessions#new'
  match '/signin', to: 'sessions#new'
  match '/signup', to: 'users#new'
end
