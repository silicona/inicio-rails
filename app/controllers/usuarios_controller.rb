class UsuariosController < ApplicationController
  def new
  	@usuario = Usuario.new
  end

  def create
  	@usuario = Usuario.new(parametros_usuario)
  	if @usuario.save
      dar_acceso_a @usuario # En SesionesHelper.rb
  		flash[:success] = "Bienvenido a la PrimeraApp"
  		redirect_to @usuario # Equivalente a redirect_to usuario_url(@usuario)
  	else
  		render 'new'
  	end
  end

  def show
  	@usuario = Usuario.find(params[:id])
  end

  private
  	def parametros_usuario
  		params.require(:usuario).permit(:nombre, :email, :password, :password_confirmation)
  	end
end
