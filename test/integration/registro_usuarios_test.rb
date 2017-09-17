require 'test_helper'

class RegistroUsuariosTest < ActionDispatch::IntegrationTest

	def setup 
		ActionMailer::Base.deliveries.clear
	end

	test "Debería registrar un nuevo usuario con activación de cuenta" do
		get registro_path
		assert_difference "Usuario.count", 1 do
			post registro_path, params: { usuario: { nombre: "Usuario de ejemplo",
																							 email: "miemail@example.com",
																							 password: "password",
																							 password_confirmation: "password" } }
		end
		assert_equal 1, ActionMailer::Base.deliveries.size
		usuario = assigns(:usuario)
		assert_not usuario.activado?
			#Intenta acceder antes de activar
		dar_acceso_como(usuario)
		assert_not estaLogeado?
			# Token de activación invalido
		get edit_activacion_cuenta_path("token invalido", email: usuario.email)
		assert_not estaLogeado?
			# Token de activación válido y email incorrecto
		get edit_activacion_cuenta_path(usuario.token_activacion, email: "erroneo")
		assert_not estaLogeado?
			# Token de activacion válido y email correcto
		get edit_activacion_cuenta_path(usuario.token_activacion, email: usuario.email)
		assert usuario.reload.activado?

		#assert_response 302 # Redirect_to usuario_path
		follow_redirect!
		assert_template "usuarios/show"
		assert flash[:success]
		assert estaLogeado?
	end

	test "No debería registrar un nuevo usuario" do
		get registro_path
		assert_no_difference "Usuario.count" do
			post registro_path, params: { usuario: { nombre: "",
																							 email: "foo@invalid",
																							 password: "foo",
																							 password_confirmation: "bar" } }
		end
		assert_template "usuarios/new"
		assert_select "div#explicacion_error"
		assert_select "div.alert"
		assert_select "div.field_with_errors"
	end

end
