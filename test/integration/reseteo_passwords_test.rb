require 'test_helper'

class ReseteoPasswordsTest < ActionDispatch::IntegrationTest
	def setup
		ActionMailer::Base.deliveries.clear
		@usuario = usuarios(:paco)
	end

	test "Restablecer la contraseña" do
		get new_reseteo_password_path
		assert_template "reseteo_passwords/new"
			# Mail inválido
		post reseteo_passwords_path, params: { reseteo_password: { email: "" } }
		assert flash[:danger]
		assert_template "reseteo_passwords/new"
			# Mail válido
		post reseteo_passwords_path, params: { reseteo_password: { email: @usuario.email } }
		assert_not_equal @usuario.digest_reseteo, @usuario.reload.digest_reseteo
		assert_equal 1, ActionMailer::Base.deliveries.size
		assert flash[:info]
		assert_redirected_to root_url
		#assert_template "fijas/inicio"
			# formulario de reseteo de contraseña
		usuario = assigns(:usuario)
			# Mail incorrecto
		get edit_reseteo_password_path(usuario.token_reseteo, email: "")
		assert_redirected_to root_url
			# Usuario sin activar
		usuario.toggle!(:activado)
		get edit_reseteo_password_path(usuario.token_reseteo, email: usuario.email)
		assert_redirected_to root_url
		usuario.toggle!(:activado)
			# Mail correcto, token inválido
		get edit_reseteo_password_path("token_inválido", email: usuario.email)
		assert_redirected_to root_url
			# Mail y token correctos
		get edit_reseteo_password_path(usuario.token_reseteo, email: usuario.email)
		assert_template "reseteo_passwords/edit"
		assert_select "input[name=email][type=hidden][value=?]", usuario.email
			# Contraseña y confirmacion inválidas
		patch reseteo_password_path(usuario.token_reseteo), params: { 
																													email: usuario.email,
																													usuario: {
																													  password: "foo",
																													  password_confirmation: "baz" } }
		assert_select "div#explicacion_error"
			# Contraseña en blanco
		patch reseteo_password_path(usuario.token_reseteo), params: { 
																													email: usuario.email,
																													usuario: {
																														password: "",
																														password_confirmation: "" } }
		assert_select "div#explicacion_error"
			# Contraseña y confirmacion correctas
		patch reseteo_password_path(usuario.token_reseteo), params: { 
																													email: usuario.email,
																													usuario: {
																														password: "pass_correcto",
																														password_confirmation: "pass_correcto" } }
		assert estaLogeado?
		assert_nil usuario.reload.digest_reseteo
		assert flash[:success]
		assert_redirected_to usuario
	end

	test "Token expirado" do
		get new_reseteo_password_path
		post reseteo_passwords_path, params: { reseteo_password: { email: @usuario.email } }
		@usuario = assigns(:usuario)
		@usuario.update_attribute(:reseteo_enviado_en, 3.hours.ago)
		patch reseteo_password_path(@usuario.token_reseteo), params: { 
																													 email: @usuario.email,
																													 usuario: {
																													   password: "password",
																														 password_confirmation: "password" } }
		assert_response :redirect
		follow_redirect!
		assert_match /expirado/i, response.body
	end
end
