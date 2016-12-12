Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#home"

  resources :contacts
  resources :announcers
  resources :ads
  resources :vacancies
  resources :galleries
  resources :publications

  get 'pages/home'
  get 'ads_categories/:id_category' => 'application#ads_categories', as: 'ads_categories'
  get 'personal_profiles/edit'
  patch 'personal_profiles/update'
  post 'personal_profiles/update_announcer'
  get 'columnists/edit'
  patch 'columnists/update'
  get 'subscribers/edit'
  patch 'subscribers/update'
  post 'announcers/create'
  post 'announcers/add_photo'


end
