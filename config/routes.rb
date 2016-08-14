Rails.application.routes.draw do
  namespace :api do
    get 'charts/:question_id/grouped_answers' => 'charts#grouped_answers', as: :question_grouped_answers
    get 'charts/:question_id/sorted_grouped_answers' => 'charts#sorted_grouped_answers', as: :question_sorted_grouped_answers
  end
  resources :collaborations, only: [:destroy]

  get 'surveys/:survey_id/charts' => 'charts#index', as: :survey_charts
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
