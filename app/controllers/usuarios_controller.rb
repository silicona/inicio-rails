class UsuariosController < ApplicationController
  before_action :usuario_accedido, only: [:index, :edit, :update, :destroy]
  before_action :usuario_correcto, only: [:edit, :update]
  before_action :usuario_admin, only: [:destroy]

  def index
    @usuarios = Usuario.paginate(page: params[:page])
  end
  
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
  end

  def destroy
    Usuario.find(params[:id]).destroy
    flash[:sucess] = "Usuario borrado"
    redirect_to usuarios_url
  end

  private
  	def parametros_usuario
  		params.require(:usuario).permit(:nombre, :email, :password, :password_confirmation)
  	end

    def usuario_accedido
      unless ha_accedido?
        guardar_URL
        flash[:danger] = "Por favor, accede primero."
        redirect_to acceder_path
      end
    end

    def usuario_correcto
      @usuario = Usuario.find(params[:id])
      redirect_to(root_url) unless usuario_actual?(@usuario)
    end

    def usuario_admin
      redirect_to(root_url) unless usuario_actual.admin?
    end
end
