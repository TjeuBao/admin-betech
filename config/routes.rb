Rails.application.routes.draw do
  resources :careers
  devise_for :users
  resources :posts
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index show]
      resources :careers, only: %i[index show] do
        resources :job_applications, only: :create
      end
    end
  end
end
