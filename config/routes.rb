Rails.application.routes.draw do
  # devise_for :users

  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords     => "users/passwords",
  }

  devise_scope :users do
    resources :users, only: [:index, :show]
    get "/users/passwords/sent", :to => "users/passwords#sent"
  end

  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
