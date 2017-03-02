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
  resources :ads, only: [:show, :update] do
    collection do
      resources :categories, only: [:show] do
        get :search, on: :member
      end
    end
  end
  resources :vacancies, except: [:index]
  resources :galleries
  resources :publications
  resources :curriculums, except: [:index]
  resources :evaluations
  resources :telephones
  resources :pub_attachments
  # fazer new como post
  resources :transactions, only: [:new, :create] do
    collection do
      get 'payment_return'
      get 'payment_review'
      post 'payment_redirect'
    end

    member do
      get 'success'
    end
  end

  get 'pages/home'
  get 'personal_profiles/edit'
  patch 'personal_profiles/update'
  post 'personal_profiles/update_announcer'
  #post 'personal_profiles/add_telephone'
  get 'columnists/edit'
  get 'columnists/:id' => 'columnists#show', as: 'columnist'
  patch 'columnists/update'
  get 'subscribers/edit'
  patch 'subscribers/update'
  patch 'subscribers/canceled_subscription', as: :canceled_subscription
  post 'announcers/create'
  post 'announcers/add_photo'
  post 'announcers/add_evaluation'
  get 'pages/:id/subscription', controller: :pages, action: :subscription, as: 'subscription'

end
