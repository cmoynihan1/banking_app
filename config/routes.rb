Rails.application.routes.draw do

  get 'home', to: 'home#index'
  root to: 'home#index'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get 'sign_in', to: 'authentication#new'
  post 'sign_in', to: 'authentication#create'
  delete 'logout', to: 'authentication#destroy'


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :transactions, only: [:index]

end
