Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :dashboard, only: [:show]
  root 'static_pages#index'
  get 'privacy', to: 'static_pages#privacy'
  get 'team', to: 'static_pages#team'
  get 'careers', to: 'static_pages#careers'
  resources :courses, only: [:index, :show] do
    resources :enrollments, only: :create
  end

  resources :lessons, only: [:show]
  namespace :instructor do
    resources :sections, only: [:update]
    resources :lessons, only: [:update]
    resources :sections, only: [] do
      resources :lessons, only: [:create]
    end
    resources :courses, only: [:new, :create, :show, :update, :edit] do
      resources :sections, only: [:create] do
        resources :lessons, only: [:new, :create]
      end
    end
  end
end
