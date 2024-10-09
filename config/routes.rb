Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "todos#index"
  resources :todos do 
    post 'complete', to: 'todos#complete', as: 'complete'
  end
  resources :projects do
    post :add_todo, on: :collection
  end 
end
