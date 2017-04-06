Rails.application.routes.draw do

  root 'tournaments#index'
  
  devise_for :users

  resources :teams
  resources :venues, only: :index

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
