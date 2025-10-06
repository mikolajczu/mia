Rails.application.routes.draw do
  root 'home#index'

  resources :chat, only: [:create]
  get '/chat', to: 'chat#index'
end
