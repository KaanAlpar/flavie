Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'users#show'
  resources :conversions, only: [:create, :show] do
    member do
      get 'choose_deck'
    end
  end
  resources :decks, only: [:show, :create, :new, :index] do
    resources :flashcards, only: [:create]
    member do
      get 'practice'
    end
  end
  resources :flashcards, only: [:edit, :update, :destroy]
end
