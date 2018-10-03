Rails.application.routes.draw do

  get 'home/index'
  get 'sessions/new'
  root to: 'places#index'
  get    '/login',   to: 'sessions#new'
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
    end
  end
end
