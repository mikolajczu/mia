Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :chats, only: %i[show new]
  resources :messages, only: %i[create]
end
