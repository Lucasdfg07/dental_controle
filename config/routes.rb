Rails.application.routes.draw do
  get 'welcome/index'

  resources :parcels
  resources :office_visits
  resources :spents
  resources :patients
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
