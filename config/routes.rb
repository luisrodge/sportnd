Rails.application.routes.draw do
  root 'tournaments#index'
  get 'information', to: 'pages#information'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

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
  resources :members , only: [:index]

  namespace :profile do
    resources :venues, except: [:show, :index]
  	resources :teams do
      resources :memberships, only: [:create, :destroy]
    end
  	resources :tournaments do
      resources :teams, except: [:show, :index]
  	end
  end

end
