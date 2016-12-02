Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#home"

  resources :contacts
  resources :announcers

  get 'pages/home'
  get 'personal_profiles/edit'
  patch 'personal_profiles/update'
  post 'personal_profiles/update_announcer'
  get 'columnists/edit'
  patch 'columnists/update'
  get 'subscribers/edit'
  patch 'subscribers/update'
#  get 'announcers/new'
  post 'announcers/create'
#  get 'announcers/show'
#  get 'announcers/edit'
#  get 'personal_profiles/edit_announcer/:id' => 'personal_profiles#edit_announcer', as: 'edit_announcer'
end
