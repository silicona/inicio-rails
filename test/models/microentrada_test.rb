require 'test_helper'

class MicroentradaTest < ActiveSupport::TestCase
	setup do
		@usuario = usuarios(:paco)
			# código incorrecto idiomáticamente
			#@microentrada = Microentrada.new(contenido: "Texto de prueba", usuario_id: @usuario.id)
		@microentrada = @usuario.microentradas.build(contenido: "Texto de prueba")
	end

	test "Debería ser válido" do
		assert @microentrada.valid?
	end

	test "Debería tener usuario" do
		@microentrada.usuario_id = nil
		assert_not @microentrada.valid?
	end

	test "Debería tener contenido" do
		@microentrada.contenido = nil
		assert_not @microentrada.valid?
	end

	test "El contenido debería ser de 140 caracteres máximo" do
		@microentrada.contenido = "a" * 141
		assert_not @microentrada.valid?
	end

	test "El orden de las microentradas deberia ser la más reciente primero" do
		assert_equal microentradas(:mas_reciente), Microentrada.first
	end
end
