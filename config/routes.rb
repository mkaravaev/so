require 'sidekiq/web'

Rails.application.routes.draw do
  
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  
  concern :commentable do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :questions, concerns: :commentable do
    resources :answers, only: [:create, :update, :destroy]
  end
  
  resources :questions, only: [] do
    post   :subscribe, on: :member
    post :unsubscribe, on: :member
  end

  resources :answers, only: [], concerns: :commentable

  resources :tags, only: [:index, :create]

  get '/search', to: 'search#search'

  # API
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end
      resources :questions, only: [:index, :show, :create] do
        resources :answers, only: [:index, :show, :create]
      end
    end
  end

  root 'questions#index'

end
