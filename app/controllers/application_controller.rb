class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SesionesHelper

  def usuario_accedido
    unless ha_accedido?
      guardar_URL
      flash[:danger] = "Por favor, accede primero."
      redirect_to acceder_path
    end
  end
  # def hola
  # 	render html: "Hola, cochino mundo!"
  # end

  # def adios
  # 	render html: "Adios muy buenas"
  # end
end
