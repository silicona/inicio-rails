Rails.application.routes.draw do
  get 'fijas/acerca'

  get 'fijas/inicio'

  get 'fijas/ayuda'

  get 'fijas/contacto'

  resources :microentradas
  resources :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "fijas#inicio"
end
