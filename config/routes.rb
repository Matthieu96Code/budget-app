Rails.application.routes.draw do
  devise_for :users

  root to: "categories#index"
  resources :categories do
    resources :operations 
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
