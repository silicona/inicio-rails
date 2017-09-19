require 'test_helper'

class PerfilUsuarioTest < ActionDispatch::IntegrationTest
	setup do
	 	@usuario = usuarios(:paco)
	end

	test "Mostrar perfil" do
		get usuario_path(@usuario)
		assert_template "usuarios/show"
		assert_select 'title', tituloCompleto(@usuario.nombre)
		assert_select 'h1', text: @usuario.nombre
		assert_select 'h1>img.gravatar'
		assert_match @usuario.microentradas.count.to_s, response.body
		assert_select 'div.pagination', count: 1
		@usuario.microentradas.paginate(page: 1).each do |microentrada|
			assert_match microentrada.contenido, response.body
		end
	end
end
