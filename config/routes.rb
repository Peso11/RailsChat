Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  root to: 'pages#index'
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  namespace :private do 
    resources :conversations, only: [:create] 
    resources :messages, only: [:index, :create]
  end
end
