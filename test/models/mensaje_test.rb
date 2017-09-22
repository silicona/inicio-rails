require 'test_helper'

class MensajeTest < ActiveSupport::TestCase

	def setup
		@mensaje = usuarios(:paco).mensajes.build(contenido: "Contenido válido")
	end

	test "Debería ser un mensaje válido" do
		assert @mensaje.valid?, @mensaje.errors.full_messages
	end

	test "El mensaje debería tener contenido" do
		@mensaje.contenido = ""
		assert !@mensaje.valid?
	end
end
