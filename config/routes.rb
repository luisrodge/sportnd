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
  	resources :teams
  	resources :tournaments do
      resources :teams
  		resources :enrollments
  	end
  end

end
