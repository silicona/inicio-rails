require 'test_helper'

class SesionesHelperTest < ActionView::TestCase

	setup do
		@usuario = usuarios(:paco)
		recuerda(@usuario)
	end

	test "usuario_actual devuelve el correcto usuario cuando la sesion es nil" do
		assert_equal @usuario, usuario_actual
		assert ha_accedido?
	end

	test "usuario_actual devuelve nil cuando digest_recuerda es nil" do
		@usuario.update_attribute(:digest_recuerda, Usuario.digest(Usuario.nuevo_token))
		assert_nil usuario_actual
	end
end