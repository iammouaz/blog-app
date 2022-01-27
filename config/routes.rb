Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: 'users#index'
  get 'user_posts/index'
  get 'user_posts/show'
  get 'users/index'
  get 'users/show'
  
  # Defines the root path route ("/")
  # root "articles#index"
end
