Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "fijas#inicio"

  get '/acceder', to: 'sesiones#new'
  post '/acceder', to: 'sesiones#create'
  delete '/salir', to: "sesiones#destroy"

  get '/acerca', to: 'fijas#acerca'
    #get '/ayuda', to: 'fijas#ayuda' # Anulado para nombrar la ruta
  get '/ayuda', to: 'fijas#ayuda', as: "sos"
  get '/contacto', to: 'fijas#contacto'

  get '/registro', to: 'usuarios#new'
  post "/registro", to: "usuarios#create"

  resources :usuarios
  resources :activacion_cuentas, only: [:edit]
  resources :reseteo_passwords, only: [:new, :create, :edit, :update]
end
