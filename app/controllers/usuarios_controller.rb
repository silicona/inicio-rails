class UsuariosController < ApplicationController
    # :usuario_accedido en controllers/application_controller.rb
  before_action :usuario_accedido, only: [:index, :edit, :update, :destroy, :siguiendo, :seguidores]
  before_action :usuario_correcto, only: [:edit, :update]
  before_action :usuario_admin, only: [:destroy]

  def index
    @usuarios = Usuario.where(activado: true).paginate(page: params[:page], per_page: 10)
  end
  
  def new
  	@usuario = Usuario.new
  end

  def create
  	@usuario = Usuario.new(parametros_usuario)
  	if @usuario.save
          # Anulado por la activacion de usuario por mail
        # dar_acceso_a @usuario # En SesionesHelper.rb
    		# flash[:success] = "Bienvenido a la PrimeraApp"
    		# redirect_to @usuario # Equivalente a redirect_to usuario_url(@usuario)
      @usuario.enviar_mail_activacion
      flash[:info] = "Por favor, comprueba tu email para activar la cuenta."
      redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(parametros_usuario)
      flash[:success] = "Tu perfil ha sido actualizado"
      redirect_to @usuario
    else
      render 'edit'
    end
  end

  def show
  	@usuario = Usuario.find(params[:id])
    redirect_to root_url and return unless @usuario.activado
    @microentrada = @usuario.microentradas.paginate(page: params[:page])
  end

  def destroy
    Usuario.find(params[:id]).destroy
    flash[:success] = "Usuario borrado"
    redirect_to usuarios_url
  end

  ### Seguir y dejar de seguir ###

  def siguiendo
    @titulo = "Siguiendo"
    @usuario = Usuario.find(params[:id])
    @avatares = @usuario.siguiendo
    @usuarios = @usuario.siguiendo.paginate(page: params[:page])
    render "show_seguir"
  end

  def seguidores
    @titulo = "Seguidores"
    @usuario = Usuario.find(params[:id])
    @avatares = @usuario.seguidores
    @usuarios = @usuario.seguidores.paginate(page: params[:page])
    render "show_seguir"
  end

  private
  	def parametros_usuario
  		params.require(:usuario).permit(:nombre, :email, :password, :password_confirmation)
  	end

    def usuario_correcto
      @usuario = Usuario.find(params[:id])
      redirect_to(root_url) unless usuario_actual?(@usuario)
    end

    def usuario_admin
      redirect_to(root_url) unless usuario_actual.admin?
    end
end
