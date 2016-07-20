Rails.application.routes.draw do
  resources :choices
  resources :questions
  resources :surveys do
    member do
      get :published
    end
  end
  resources :sessions, only: [:new, :create]
  resources :users
  root 'surveys#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
