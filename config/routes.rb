Rails.application.routes.draw do

  root to: 'events#index'
  get    '/login',   to: 'sessions#new'
  get    '/signup',   to: 'users#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :events do
    member do
      get :finalize_place
    end
  end
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
      get :vote
    end
  end
end
