Rails.application.routes.draw do
  #mount ActionCable.server => "/cable"

  #root 'pages#overview'

  root 'tournaments#index'
  get 'about', to: 'pages#about'

  devise_for :members, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }, :skip => [:registrations]
  as :member do
    get 'members/edit' => 'devise/registrations#edit', :as => 'edit_member_registration'
    put 'members' => 'devise/registrations#update', :as => 'member_registration'
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
    resource :after_signup, only: [:show, :update]
    resources :venues, except: [:show, :index]
  	resources :teams do
      resources :memberships, only: [:create, :destroy]
    end
  	resources :tournaments do
      resources :teams, except: [:show, :index]
  	end
  end

end
