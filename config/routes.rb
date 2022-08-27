Rails.application.routes.draw do
  # devise_for :users

  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords     => "users/passwords",
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/session#destroy'

    get "/users/:id", :to => "users#show", as: 'user'
    get "/users", :to => "users#index"
    get "/users/passwords/sent", :to => "users/passwords#sent"
    get "signup", :to => "users/registrations#new"
    # get "login", :to => "users/sessions#new"
    # get "logout", :to => "users/sessions#destroy"
  end

  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
