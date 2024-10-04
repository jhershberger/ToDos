Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "todos#index"
  resources :todos
end
