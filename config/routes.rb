Rails.application.routes.draw do
  root 'tournaments#index'
  get 'information', to: 'pages#information'

  devise_for :users, skip: [:sessions]
  as :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resource :tournaments, only: :index do
    get :pagination
  end
  resource :teams, only: :index do
    get :pagination
  end
  resource :members, only: :index do
    get :pagination
  end

  resources :tournaments, only: [:index, :show]
  resources :venues, only: :index
  resources :teams , only: :index
  resources :members , only: [:index, :show]

  namespace :profile do
    resources :venues, only: :new
  	resources :teams do
      resources :memberships, only: [:create, :destroy]
    end
  	resources :tournaments do
      resources :teams, except: [:show, :index]
  	end
  end

end
