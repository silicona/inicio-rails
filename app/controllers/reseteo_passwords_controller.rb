class ReseteoPasswordsController < ApplicationController
	before_action :obtener_usuario, only: [:edit, :update]
	before_action :usuario_valido, only: [:edit, :update]
	before_action :comprobar_expiracion, only: [:edit, :update]

  def new
  end

  def create
  	@usuario = Usuario.find_by(email: params[:reseteo_password][:email].downcase)
  	if @usuario
  		@usuario.crear_digest_reseteo
  		@usuario.enviar_mail_reseteo
  		flash[:info] = "Enviado email con las intrucciones para restablecer la contraseña."
  		redirect_to root_url
  	else
  		flash.now[:danger] = "La dirección email no está registrada."
  		render "new"
  	end
  end

  def edit
  end

  def update
  	if params[:usuario][:password].empty?
  		@usuario.errors.add(:password, "no puede estar en blanco.")
  		render "edit"
  	elsif @usuario.update_attributes(parametros_usuario)
  		dar_acceso_a @usuario
  			# Medida de seguridad, en caso de pulsar 'Atras' en el navegador
  		@usuario.update_attribute(:digest_reseteo, nil)
  		flash[:success] = "La contraseña ha sido actualizada."
  		redirect_to @usuario
  	else
  		render "edit"
  	end
  end

  private
  	def parametros_usuario
  		params.require(:usuario).permit(:password, :password_confirmation)
  	end

  	def obtener_usuario
  		@usuario = Usuario.find_by(email: params[:email])
  	end

  	def usuario_valido
  		unless(@usuario && @usuario.activado? && @usuario.autentificado?(:reseteo, params[:id]))
  			redirect_to root_url
  		end
  	end

  	def comprobar_expiracion
  		if @usuario.reseteo_password_expirado?
  			flash[:danger] = "El restablecimento de la contraseña ha expirado"
  			redirect_to new_reseteo_password_url
  		end
  	end
end
