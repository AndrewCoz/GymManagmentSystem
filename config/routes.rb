Rails.application.routes.draw do
  resources :gym_classes do
    member do
      post 'add_member'
      delete 'remove_member'
    end
  end
  
  resources :trainers
  resources :members
  
  get 'dashboard', to: 'dashboard#index'
  
  # Health check endpoints
  get '/health', to: 'health#check'
  get '/up', to: 'health#check'
  get '/ping', to: 'simple#ping'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dashboard#index"
end
