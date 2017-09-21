require 'test_helper'

class RelacionesControllerTest < ActionDispatch::IntegrationTest

	test "Debería edirigir desde crear si no ha accedido" do
		assert_no_difference "Relacion.count" do
			post relaciones_path
		end
		assert_redirected_to acceder_path
	end

	test " Debería redirigir desde destroy si no ha accedido" do
		assert_no_difference "Relacion.count" do
			delete relacion_path(relaciones(:uno))
		end
		assert_redirected_to acceder_path
	end
end
