class MensajesController < ApplicationController
	before_action :usuario_accedido
  before_action :confirmar_cookie
	before_action :obtener_mensajes

    # Modificado config/initailizers/assets.rb para llamar al estilo mensajes.sass
    #  en las vistas 
  layout "cable"
  
  def index
    @titulo = "Chat de PrimeraApp"

  end

  def create
      # Se ejecuta con Ajax en _formulario_mensaje.html.erb
    @titulo = "Desde crear"
  	mensaje = usuario_actual.mensajes.build(parametros_mensaje)
  	if mensaje.save
  		  # Activa el servidor para el canal señalado con un hash de contenidos
        # Se recibe en app/assets/javascripts/channels/sala.cofee
      #ActionCable.server.broadcast 'canal_sala', contenido: mensaje.contenido, nombre: mensaje.usuario.nombre
      
      ActionCable.server.broadcast 'canal_sala', mensaje: renderizar_mensaje(mensaje)
      
      mensaje.menciones.each do |mencion|
        ActionCable.server.broadcast 'canal_sala_usuario_#{mencion.id}', mention: true,
                                                                         autor: mensaje.usuario
      end

      #head :ok
        # Inicio
      # redirect_to mensajes_url
  	   # else
  	 #	render 'index'
  	end
    # debugger
  end

  private

    def confirmar_cookie
      if !(id_usuario = cookies.signed[:chat])
        recuerda(usuario_actual)
      end
    end

    def renderizar_mensaje(mensaje)
      render(partial: "mensaje", locals: { mensaje: mensaje })
    end

  	def obtener_mensajes
  		@mensajes = Mensaje.para_mostrar
  		@mensaje = usuario_actual.mensajes.build
  	end

  	def parametros_mensaje
  		params.require(:mensaje).permit(:contenido)
  	end
end
