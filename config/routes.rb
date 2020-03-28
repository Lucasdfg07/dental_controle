Rails.application.routes.draw do
  resources :graphs, only: [:index] do
  	collection do
      get 'index'
  		post 'index'
  	end
  end

  resources :parcels
  
  resources :office_visits do
    collection do
      get 'export'
    end
  end

  resources :spents
  
  resources :patients do
    collection do
      get 'export'
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :welcome, only: [:index] do
    collection do
      get 'index'
      get 'export'
      post 'index'
      post 'send_mail'
    end
  end

  resources :calendar

  root 'welcome#index'
  

  namespace :superuser do
    get 'welcome/index'

    resources :users
  end
end
