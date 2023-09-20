Rails.application.routes.draw do
  get 'welcome/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
  get '/welcome', to: 'welcome#index'
  resources :users, only: [:new, :create]
end
