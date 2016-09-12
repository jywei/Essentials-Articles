Rails.application.routes.draw do

  # devise_for :users, :controllers => { registrations: 'registrations' }
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }

  # devise_scope :user do
  #   post "deactivate", to: "registrations#deactivate", as: "deactivate_registration"
  # end

  resources :articles do
    resources :comments
  end
  resources :contacts
  root to: 'pages#index'
  get 'pages/contact'
  get 'pages/about'

end
