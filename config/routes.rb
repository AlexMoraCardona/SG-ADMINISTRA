Rails.application.routes.draw do

  root :to =>  'homes#index' 
  get 'home', to:  "homes#index"
  

  namespace :authentication, path: '', as: ''  do
    resources :users
    resources :sessions, only: [:new, :create, :destroy]
  end  
  
  resources :levels

end
