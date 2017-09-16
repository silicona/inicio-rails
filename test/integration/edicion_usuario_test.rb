require 'test_helper'

class EdicionUsuarioTest < ActionDispatch::IntegrationTest

	def setup
		@usuario = usuarios(:paco)
		@shilum = usuarios(:shilum)
	end

	test "No debería editar el perfil" do
		dar_acceso_como(@usuario)
		get edit_usuario_path(@usuario)
		assert_template "usuarios/edit"
		patch usuario_path(@usuario), params: { usuario: { nombre: "",
																											 email: "foo@invalido",
																											 password: "solo5",
																											 password_confirmation: "baz" } }
		assert_template "usuarios/edit"
		assert_select 'div', 'El formulario contiene 4 errores'
	end

		#Anulado para hacer test de redireccionamiento amigable
	# test "Debería poderse editar el perfil" do
	# 	dar_acceso_como(@usuario)
	# 	get edit_usuario_path(@usuario)
	# 	assert_template "usuarios/edit"
	test "Debería redirigir de forma amigable para editar el perfil" do
		get edit_usuario_path(@usuario)
		dar_acceso_como(@usuario)
		assert_redirected_to edit_usuario_url(@usuario)
		nombre = "El grande"
		email = "unmail@example.com"
		patch usuario_path(@usuario), params: { usuario: { nombre: nombre,
																											 email: email,
																											 password: "",
																											 password_confirmation: "" } }
		assert_not flash.empty?
		assert_redirected_to @usuario
		@usuario.reload
		assert_equal nombre, @usuario.nombre
		assert_equal email, @usuario.email
		assert_nil session[:url_deseada]
	end

	test "Debería redirigir desde edit si no se ha accedido" do
		get edit_usuario_path(@usuario)
		assert_not flash.empty?
		assert flash[:danger]
		assert_redirected_to acceder_url
	end

	test "Debería redirigir desde update si no se ha accedido" do
		patch usuario_path(@usuario), params: { usuario: { nombre: @usuario.nombre,
																											 email: @usuario.email } }
		assert_not flash.empty?
		assert flash[:danger]
		assert_redirected_to acceder_url
	end

	test "Debería redirigir desde edit si no es el usuario correcto" do
		dar_acceso_como(@shilum)
		get edit_usuario_path(@usuario)
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "Debería redirigir desde update si no es el usuario correcto" do
		dar_acceso_como(@shilum)
		patch usuario_path(@usuario), params: { usuario: { nombre: @shilum.nombre,
																											 email: "otromail@falso.com" } }
		assert flash.empty?
		assert_redirected_to root_url
	end

end
