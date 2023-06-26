Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope module: "api" do
    scope module: "v1" do
      post '/auth/signup', to: "authentications#signup"
      post '/auth/login', to: "authentications#login"
      put '/carts', to: "carts#update"
      resources :products, only: [:index, :show]
      resources :carts, only: [:index, :create, :destroy, :show]
      resources :orders, only: [:index, :create, :destroy]
    end
  end
end
