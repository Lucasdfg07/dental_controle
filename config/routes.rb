Rails.application.routes.draw do
  resources :parcels
  
  resources :office_visits

  resources :spents
  resources :patients
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :welcome

  root 'welcome#index'
end
