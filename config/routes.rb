Rails.application.routes.draw do
  resources :choices, only: [:destroy]
  resources :questions, only: [:destroy]
  resources :surveys do
    resources :responses
    resources :collaborations
  end
  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy'
  resources :users
  root 'surveys#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
