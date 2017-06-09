Rails.application.routes.draw do
  #mount ActionCable.server => "/cable"

  root 'tournaments#index'
  get 'details', to: 'pages#home'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
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
  resources :members , only: [:index]
  
  namespace :profile do
    resources :venues, except: [:show, :index]
  	resources :teams do
      resources :memberships, only: [:create, :destroy]
    end
    resource :new_tournament do
      get :step1
      get :step2
      get :step3
      get :step4
  
      post :validate_step
    end
  	resources :tournaments do
      resources :teams, except: [:show, :index]
  	end
  end

end
