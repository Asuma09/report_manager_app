Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks do
    resources :data, only: [:new, :create, :destroy]
  end
end
