require 'test_helper'

class InterfazMicroentradaTest < ActionDispatch::IntegrationTest
	def setup
		@usuario = usuarios(:paco)

			# Anulada la redimensión de imagenes en config7initializers/evitar_redimension_imagen.rb
	end

	test "Gestión de microentradas" do
		dar_acceso_como(@usuario)
		get root_path
		assert_select 'div.pagination'
			# div de boton cargador de imagenes
		assert_select 'input[type=file]'

			# Envio inválido
		assert_no_difference 'Microentrada.count' do
			post microentradas_path, params: { microentrada: { contenido: "" } }
		end
		assert_template "fijas/inicio"
		assert_select 'div#explicacion_error'
		assert_select 'ol.microentradas'
		@objetos = assigns(:objetos_publicados)
		
		if assert_not @objetos.empty?
			@objetos.each do
				assert_select "a[href=?]", usuario_path(@usuario)
			end
			assert_select 'div.pagination'
		end
		
			# Envio válido
		contenido = "Esta microentrada de prueba es valida"
			# imagen cargada desde /fixtures
		imagen = fixture_file_upload('test/fixtures/rails.png', 'image/png')
		assert_difference 'Microentrada.count' do
			post microentradas_path, params: { microentrada: { contenido: contenido,
																												 imagen: imagen } }
		end
		assert Microentrada.first.imagen?
		assert_redirected_to root_url
		follow_redirect!
		assert_match contenido	, response.body

			# Borrar post
		assert_select 'a', text: 'PrimeraApp'
		assert_select 'a[href^="/microentradas/"]', text: 'borrar'
		primera_microentrada = @usuario.microentradas.paginate(page: 1).first
		assert_difference 'Microentrada.count', -1 do
			delete microentrada_path(primera_microentrada)
		end

			# Ver un usuario diferente
		get usuario_path(usuarios(:shilum))
		assert_select 'a', text: "Borrar", count: 0
	end

	test "Contador de microentradas del sidebar" do
		dar_acceso_como(@usuario)
		get root_path
		assert_match "4 microentradas", response.body
			# Usuario sin publicaciones
		otro_usuario = usuarios(:clara)
		dar_acceso_como(otro_usuario)
		get root_path
		assert_match "2 microentradas", response.body
		otro_usuario.microentradas.create!(contenido: "Una publicación sencilla")
		get root_path
		assert_match "3 microentrada", response.body
	end
end
