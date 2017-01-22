Rails.application.routes.draw do
  root to: 'products#index'

  resources :products, only: [:index] do
    collection do
      post :archive
    end
  end

  resources :user_sessions, only: [:new, :create, :destroy]

  resources :users, only: [:show]

  get  'login'  => 'user_sessions#new',     :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
