Rails.application.routes.draw do
  resources :graphs, only: [:index] do
  	collection do
      get 'index'
  		post 'index'
  	end
  end

  resources :parcels
  
  resources :office_visits

  resources :spents
  resources :patients
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :welcome, only: [:index] do
    collection do
      get 'index'
      post 'index'
      post 'send_mail'
    end
  end

  resources :calendar

  root 'welcome#index'
end
