require 'test_helper'

class IndiceUsuariosTest < ActionDispatch::IntegrationTest
	setup do
		@usuario = usuarios(:paco)
	end

	test "Index debería paginar" do
		dar_acceso_como @usuario
		get usuarios_path
		assert_template "usuarios/index"
		assert_select "div.pagination", count: 2
		Usuario.paginate(page: 1).each do |usuario|
			assert_select "a[href=?]", usuario_path(usuario), text: usuario.nombre
		end
	end

end
