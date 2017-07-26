Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  namespace :admin do
    resources :users
    resources :hotels

    root to: 'users#index'
  end

  devise_for :users,
             controllers: { sessions: 'users/sessions',
                            registrations: 'users/registrations' }

  root 'static_pages#home'

  match '/home', to: 'static_pages#home', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  resources :users, only: [:show]
  resources :hotels
  resources :reviews, only: [:create, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
