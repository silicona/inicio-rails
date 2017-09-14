Rails.application.routes.draw do

  get '/acerca', to: 'fijas#acerca'

  #get '/ayuda', to: 'fijas#ayuda' # Anulado para nombrar la ruta
  get '/ayuda', to: 'fijas#ayuda', as: "sos"

  get '/contacto', to: 'fijas#contacto'

  resources :usuarios
  get '/registro', to: 'usuarios#new'
  post "/registro", to: "usuarios#create"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "fijas#inicio"
end
