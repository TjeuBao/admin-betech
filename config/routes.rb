Rails.application.routes.draw do
  resources :careers do
    resources :job_submissions
  end
  devise_for :users
  resources :posts
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index show]
      resources :careers, only: %i[index show]
      resources :job_submissions
    end
  end
end
