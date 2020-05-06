Rails.application.routes.draw do
  resources :careers
  devise_for :users
  resources :posts
  root 'home#index'
end
