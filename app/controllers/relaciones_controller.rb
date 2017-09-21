class RelacionesController < ApplicationController
	before_action :usuario_accedido, only: [:create, :destroy]

		# Ajax - para crear y destruir
		# continua en config/application.rb
		# Se invoca el archivo <nombre_metodo>.js.erb
		# Inclusion de codigo en config/application.rb
	def create
		@usuario = Usuario.find(params[:seguido_id])
		usuario_actual.seguir(@usuario)
			# respuesta para AJAX
		respond_to do |formato|
			formato.html { redirect_to @usuario }
			formato.js
		end
	end

	def destroy
		@usuario = Relacion.find(params[:id]).seguido
		usuario_actual.dejar_de_seguir(@usuario)
			# respuesta para AJAX
		respond_to do |formato|
			formato.html { redirect_to @usuario }
			formato.js
		end
	end

end
