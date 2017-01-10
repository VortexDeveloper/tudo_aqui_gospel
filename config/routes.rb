Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'
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
  resources :curriculums
  resources :evaluations
  resources :telephones
  resources :pub_attachments

  get 'pages/home'
  get 'ads_categories/:id_category' => 'application#ads_categories', as: 'ads_categories'
  get 'personal_profiles/edit'
  patch 'personal_profiles/update'
  post 'personal_profiles/update_announcer'
  #post 'personal_profiles/add_telephone'
  get 'columnists/edit'
  get 'columnists/:id' => 'columnists#show', as: 'columnist'
  patch 'columnists/update'
  get 'subscribers/edit'
  patch 'subscribers/update'
  post 'announcers/create'
  post 'announcers/add_photo'
  post 'announcers/add_evaluation'

end
