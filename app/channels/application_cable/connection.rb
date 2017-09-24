module ApplicationCable
  class Connection < ActionCable::Connection::Base
   	#Definicion de la clase - Capa de seguridad de ActionCable

   	include SesionesHelper
   		#accesor de ActionCable
   	identified_by :usuario_chat

   	def connect
   		self.usuario_chat = verificar_usuario
      logger.add_tags 'ActionCable', usuario_chat.nombre
   	end

   	private
	  	def verificar_usuario
        
	  		if (usuario_verificado = Usuario.find_by(id: cookies.signed[:chat]))
          usuario_verificado
	  		else
	  			reject_unauthorized_connection
	  		end
	  	end
  end
end
