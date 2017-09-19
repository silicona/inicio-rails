class MicroentradasController < ApplicationController
	before_action :usuario_accedido, only: [:create, :destroy]
	before_action :usuario_correcto, only: :destroy

	def create
		@microentrada = usuario_actual.microentradas.build(parametros_microentrada)
		if @microentrada.save
			flash[:success] = "¡Microentrada creada!"
			redirect_to root_url
		else
			@objetos_publicados = []
			#@objetos_publicados = usuario_actual.microentradas # Error
			render "fijas/inicio"
		end
	end

	def destroy
		@microentrada.destroy
		flash[:success] = "Microentrada borrada"
			# redirige a la URL anterior o root (este útlimo, por algunos tests)
		redirect_to request.referrer || root_url
		#redirect_back(fallback_location: root_url)
	end

	private
		def parametros_microentrada
			params.require(:microentrada).permit(:contenido, :imagen)
		end

		def usuario_correcto
			@microentrada = usuario_actual.microentradas.find_by(id: params[:id])
			redirect_to root_url if @microentrada.nil?
		end
end
