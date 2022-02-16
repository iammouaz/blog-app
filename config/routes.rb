Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create]
    resources :posts, only: [:show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end
