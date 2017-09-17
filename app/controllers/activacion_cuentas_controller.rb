class ActivacionCuentasController < ApplicationController

  def edit
  	usuario = Usuario.find_by(email: params[:email])
  	if usuario && !usuario.activado? && usuario.autentificado?(:activacion, params[:id])
  		usuario.activar
  		dar_acceso_a usuario
  		flash[:success] = "¡Cuenta activada!"
  		redirect_to usuario
  	else
  		flash[:danger] = "Enlace de activación invalido"
  		redirect_to root_url
  	end
  end
end
