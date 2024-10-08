Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "todos#index"
  resources :todos do 
    post 'complete', to: 'todos#complete', as: 'complete'
  end
end
