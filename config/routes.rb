Rails.application.routes.draw do
  root 'tournaments#index'
  get 'information', to: 'pages#information'

  devise_for :users, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :venues, only: :index
  resources :teams , only: :index
  resources :members , only: :index

  resource :tournaments, only: [:index] do
    get :pagination
  end

  resources :tournaments, only: [:index, :show]

  namespace :profile do
    resources :venues, only: :new
  	resources :teams do
      resources :memberships
    end
  	resources :tournaments do
      resources :teams
  		resources :enrollments
  	end
  end

end
