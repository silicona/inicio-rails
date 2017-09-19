require 'test_helper'

class MicroentradasControllerTest < ActionDispatch::IntegrationTest

	setup do
		@microentrada = microentradas(:naranja)
	end

	test "Debería redirigir desde create si no se ha accedido" do
		assert_no_difference 'Microentrada.count' do
			post microentradas_path, params: { microentrada: { contenido: "Texto de prueba" } }
		end
		assert_redirected_to acceder_url
	end

	test "Debería redirigir desde destroy si no se ha accedido" do
		assert_no_difference 'Microentrada.count' do
			delete microentrada_path(@microentrada)
		end
		assert_redirected_to acceder_url
	end

	test "Debería redirigir desde destroy debido a una microentrada incorrecta" do
		dar_acceso_como(usuarios(:paco))
		microentrada = microentradas(:hormigas)
		assert_no_difference "Microentrada.count" do
			delete microentrada_path(microentrada)
		end
		assert_redirected_to root_url
	end
end
