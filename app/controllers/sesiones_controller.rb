class SesionesController < ApplicationController
		# Ayudante de Sesiones incluido en application_controller.rb para usarlo en todos los controladores
  def new
  end

  def create
      # Redefinido usuario como @usuario para usar assigns(:usuario) en integration/acceso_usuarios_test.rb
  	@usuario = Usuario.find_by(email: params[:sesiones][:email].downcase)
  	if @usuario && @usuario.authenticate(params[:sesiones][:password])
  		dar_acceso_a @usuario
      params[:sesiones][:recuerda_me] == '1' ? recuerda(@usuario) : olvidar(@usuario)
      redirect_to @usuario # equivalente a redirect_to usuario_url(usuario)
  	else	
  			# flash.now se ejecuta solo en la siguiente pantalla. Se usa al redirigir con render y no con redirect_to
  		flash.now[:danger] = "El usuario o la contraseña no son correctos"
  		render 'new'
  	end
  end

  def destroy
  	cerrar_acceso
  	redirect_to root_url
  end
end
