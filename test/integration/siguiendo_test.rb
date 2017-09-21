require 'test_helper'

class SiguiendoTest < ActionDispatch::IntegrationTest

	def setup
		@usuario = usuarios(:paco)
		@shilum = usuarios(:shilum)
		dar_acceso_como(@usuario)
	end

	test "Página Siguiendo" do
		get siguiendo_usuario_path(@usuario)
		assert_not @usuario.siguiendo.empty?
		assert_match @usuario.siguiendo.count.to_s, response.body
		@usuario.siguiendo.each do |usuario|
			assert_select "a[href=?]", usuario_path(usuario)
		end
	end

	test "Página Seguidores" do
		get seguidores_usuario_path(@usuario)
		assert_not @usuario.seguidores.empty?
		assert_match @usuario.seguidores.count.to_s, response.body
		@usuario.seguidores.each do |usuario|
			assert_select "a[href=?]", usuario_path(usuario)
		end
	end

	test "Debería seguir a un usuario de forma normal" do
		assert_difference "@usuario.siguiendo.count", 1 do
			post relaciones_path, params: { seguido_id: @shilum.id}
		end
	end

	test "Debería seguir a un usuario con Ajax" do
		assert_difference "@usuario.siguiendo.count", 1 do
			post relaciones_path, xhr: true, params: { seguido_id: @shilum.id}
		end
	end

	test "Debería dejar de seguir a alguien de forma normal" do
		@usuario.seguir(@shilum)
		relacion = @usuario.relaciones_activas.find_by(seguido_id: @shilum.id)
		assert_difference "@usuario.siguiendo.count", -1 do
			delete relacion_path(relacion)
		end
	end

	test "Debería dejar de seguir a alguien con Ajax" do
		@usuario.seguir(@shilum)
		relacion = @usuario.relaciones_activas.find_by(seguido_id: @shilum.id)
		assert_difference "@usuario.siguiendo.count", -1 do
			delete relacion_path(relacion), xhr: true
		end
	end

	test "Publicado en Página Inicio" do
		get root_path
		@usuario.publicado.paginate(page: 1).each do |microentrada|
			assert_match microentrada.contenido, response.body
		end
	end
end
