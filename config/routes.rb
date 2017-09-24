Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "fijas#inicio"


  get 'gestion_archivos/subir'
  post 'gestion_archivos/subir'

  get 'gestion_archivos/listar', as: "listar"

  post 'gestion_archivos/borrar'

  get 'gestion_archivos/guardar_comentario'
  post 'gestion_archivos/guardar_comentario'

  ## Chat
  get 'mensajes/index'
  get 'mensajes/create'

  ## Fijas
  get '/acceder', to: 'sesiones#new'
  post '/acceder', to: 'sesiones#create'
  delete '/salir', to: "sesiones#destroy"

  get '/acerca', to: 'fijas#acerca'
    #get '/ayuda', to: 'fijas#ayuda' # Anulado para nombrar la ruta
  get '/ayuda', to: 'fijas#ayuda', as: "sos"
  get '/contacto', to: 'fijas#contacto'

  get '/registro', to: 'usuarios#new'
  post "/registro", to: "usuarios#create"

  get "/microentradas", to: 'microentradas#create', microentrada: { contenido: "" }

  resources :usuarios do
      # member permite que la URL de cada usuario ejecute el bloque
      # collection opera sin :id
    member do
        # usuarios/1/siguiendo y ...
      get :siguiendo, :seguidores
    end
  end

  resources :activacion_cuentas, only: [:edit]
  resources :reseteo_passwords, only: [:new, :create, :edit, :update]
  resources :microentradas, only: [:create, :destroy]
  resources :relaciones, only: [:create, :destroy]

    # Para el chat del Cable
  # get '/chat', to: 'mensajes#index'
  resources :mensajes

  mount ActionCable.server, at: '/cable'
end
