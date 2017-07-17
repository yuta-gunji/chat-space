Rails.application.routes.draw do
  devise_for :users
  root   'groups#index'
  resources :users, only: [:edit, :update, :index]
  resources :groups, except: [:show, :destroy] do
    resources :messages, only: [:index, :create]
  end
end
