Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  # Defines the root path route ("/")
  root "pages#home"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the dashboard path route ("/dashboard")
  get "dashboard" => "dashboard#index", as: :dashboard

  # Defines get inss discount
  get 'proponents/inss_discount', to: 'proponents#inss_discount'

  # Defines the proponents path route ("/proponents")
  resources :proponents
end
