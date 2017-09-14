class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SesionesHelper

  # def hola
  # 	render html: "Hola, cochino mundo!"
  # end

  # def adios
  # 	render html: "Adios muy buenas"
  # end
end
