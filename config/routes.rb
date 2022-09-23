Rails.application.routes.draw do
  get 'notifications/index'
  get 'profile/show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'search/index'
    resources :notifications, only: [:index]
  

  get 'welcome/index'
  resources :users do
    collection do
      get :search
    end
     member do
      get :confirm_email
    end
  end

  resources :posts do
    resources :comments  
  end
  
resources :rooms do
  resources :messages
end
  
  
  resources :likes, only: [:create, :destroy]
 
  resources :friendships

  root 'sessions#new'
  resources :home do
   collection do
     get :about_us
   end
  end
  mount ActionCable.server => '/cable'  
  resources :sessions
  get 'logout', to: 'sessions#destroy', as: 'logout' 
  # Defines the root path route ("/")
  # root "articles#index"
end
