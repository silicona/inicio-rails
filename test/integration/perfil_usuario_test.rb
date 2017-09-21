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
		assert_template "compartido/_estadisticas"
		dar_acceso_como @usuario
		get root_url
		assert_template "compartido/_estadisticas"
	end

	test "Ver otro perfil" do
		dar_acceso_como @usuario
		get usuario_path(usuarios(:shilum))
		assert_template "usuarios/show"
		assert_template "compartido/_estadisticas"
		assert_template "usuarios/_formulario_seguir"
		assert_template "usuarios/_seguir"
		assert_template partial: "_dejar_de_seguir", count: 0
	end
end
