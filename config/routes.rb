Rails.application.routes.draw do
  get "data/new"
  root 'tasks#index'
  resources :tasks do
    resources :data, only: [:new, :create, :destroy]
  end
end
