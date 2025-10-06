Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :chat, only: [:create]
  get '/chat', to: 'chat#index'
end
