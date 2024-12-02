Rails.application.routes.draw do
  resources :users
  resources :posts do
    resources :comments, only: [:create]
  end
  root 'home#index'

  get 'about', to: 'pages#about'

  get 'projects', to: 'pages#projects'

  get 'newsletter', to: 'pages#newsletter'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'

  get '/search', to: 'posts#search', as: 'search'

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
