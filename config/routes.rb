Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :reports do 
    # module: :reports
    # -> comments#xxx ではなく reports/comments#xxx の controller を見る
    resources :comments, module: :reports, only: %i[show create]
  end
  resources :books
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
  end
end
