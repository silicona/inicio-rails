class MensajesController < ApplicationController
	before_action :usuario_accedido
	before_action :obtener_mensajes

    # Modificado config/initailizers/assets.rb para llamar al estilo mensajes.sass
    #  en las vistas 
  layout "cable"
  
  def index
    @titulo = "Ver mensaje"
  end

  def create
    @titulo = "Desde crear"
  	mensaje = usuario_actual.mensajes.build(parametros_mensaje)
  	if mensaje.save
  		redirect_to mensajes_url
  	else
  		render 'index'
  	end
  end

  private

  	def obtener_mensajes
  		@mensajes = Mensaje.para_mostrar
  		@mensaje = usuario_actual.mensajes.build
  	end

  	def parametros_mensaje
  		params.require(:mensaje).permit(:contenido)
  	end
end
