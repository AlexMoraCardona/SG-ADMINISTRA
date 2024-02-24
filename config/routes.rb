Rails.application.routes.draw do

  root :to =>  'homes#index' 
  get 'home', to:  "homes#index"
  

  namespace :authentication, path: '', as: ''  do
    resources :users
    resources :sessions, only: [:new, :create, :destroy]
  end  
  
  resources :levels
  resources :adm_calendars
  resources :calendars
  resources :activities
  resources :squares
  resources :places
  
  get '/adm_calendars/generar/:id', to: 'adm_calendars#generar', as: 'generar' 
  get '/adm_calendars/generaractivities/:id', to: 'adm_calendars#generaractivities', as: 'generaractivities' 
  get '/adm_calendars/ver_calendario/:id', to: 'adm_calendars#ver_calendario', as: 'ver_calendario' 
  get '/calendars/detail/:id', to: 'calendars#detail', as: 'detail' 
  get '/calendars/nueva_actividad/:id', to: 'calendars#nueva_actividad', as: 'nueva_actividad' 
  get '/calendars/seleccion/:id', to: 'calendars#seleccion', as: 'seleccion' 
  post '/calendars/seleccion/:id' => 'calendars#citar', as: 'citar'
  get '/activities/reser/:id', to: 'activities#reser', as: 'reser' 

end
