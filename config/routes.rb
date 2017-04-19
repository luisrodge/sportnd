Rails.application.routes.draw do

  root 'tournaments#index'

  devise_for :users, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :venues, only: :index
  resources :teams , only: :index

  resource :tournaments, only: [:index] do
    get :pagination
  end

  resources :tournaments

  namespace :profile do
    resources :venues
  	resources :teams do
      member do
        put "join"
        delete "leave"
      end
    end
  	resources :tournaments do
      resources :teams
  		resources :enrollments
  	end
  end

end
