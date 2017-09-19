class FijasController < ApplicationController
  def inicio
  		# Modificado para incluir @objetos_publicados
  	#@microentrada = usuario_actual.microentradas.build if ha_accedido?
  	if ha_accedido?
  		@microentrada = usuario_actual. microentradas.build
  		@objetos_publicados = usuario_actual.publicado.paginate(page: params[:page])
  	end
  end

  def ayuda
  end

  def acerca
  end

  def contacto
  end
end
