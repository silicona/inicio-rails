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
end
