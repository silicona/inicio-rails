require 'test_helper'

class RegistroUsuariosTest < ActionDispatch::IntegrationTest

	test "Debería registrar un nuevo usuario" do
		get registro_path
		assert_difference "Usuario.count", 1 do
			post registro_path, params: { usuario: { nombre: "Paco",
																							 email: "miemail@example.com",
																							 password: "password",
																							 password_confirmation: "password" } }
		end
		#assert_response 302 # Redirect_to usuario_path
		follow_redirect!
		assert_template "usuarios/show"
		assert flash[:success]
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
	end

end
