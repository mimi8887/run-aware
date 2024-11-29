Rails.application.routes.draw do
  devise_for :users
  root to: "routes#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"


  resources :routes, only: %i[index new create show results] do
    resources :runs, only: %i[create ] do
      get '/running', to: 'runs#running', as: :running
    end
    resources :bookmarks, only: %i[create]
  end

  get '/results', to: 'routes#results', as: :results
  patch '/end_run/:id', to: 'runs#end_run', as: :end_run
  resources :runs, only: %i[edit update show]
  get "style", to: "pages#style"

  resources :bookmarks, only: %i[index]
end
