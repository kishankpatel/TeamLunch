Rails.application.routes.draw do

  resources :events
  get 'home/index'
  get 'sessions/new'
  root to: 'places#index'
  get    '/login',   to: 'sessions#new'
  get    '/signup',   to: 'users#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:new, :create, :index] do 
    collection do
      get :accept_invitation
    end
    member do
      post :reset_password
    end
  end
  resources :places, only: [:new, :create, :index] do
  	member do
      get :finalize
      get :approve
    end
  end
end
