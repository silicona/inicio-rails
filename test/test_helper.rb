ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include ApplicationHelper
  # Add more helper methods to be used by all tests here...

  	# Devuelve true si un usuario de pruebas ha accedido
  def estaLogeado?
  	!session[:id_usuario].nil?
  end

  	# Acceder como un usuario en los test de controladores
  def dar_acceso_como
  	session[:id_usuario] = usuario.id
  end

end

class ActionDispatch::IntegrationTest

  	# Acceder como un usuario en los test de integracion
	def dar_acceso_como(usuario, password: 'password', recuerda_me: '1')
		post acceder_path, params: { sesiones: { email: usuario.email,
																						 password: password,
																						 recuerda_me: recuerda_me } }
	end
end