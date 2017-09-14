require 'test_helper'

class AccesoUsuariosTest < ActionDispatch::IntegrationTest
	setup do
		@usuario = usuarios(:paco)
	end

	test "No debería acceder con informacion inválida" do
		get acceder_path
		assert_template "sesiones/new"
		post acceder_path, params: { sesiones: { email: "foo@ddd",
																						 password: "pass" } }
		assert_template "sesiones/new"
		assert_not flash.empty?
		get root_url
		assert flash.empty?
	end

	test "Debería acceder el usuario y salir" do
		get acceder_path
		post acceder_path, params: { sesiones: { email: @usuario.email,
																						 password: 'password' } }
		assert estaLogeado?
		assert_redirected_to @usuario
		follow_redirect!
		assert_template 'usuarios/show'
		assert_select 'a[href=?]', acceder_path, count: 0
		assert_select 'a[href=?]', salir_path
		assert_select 'a[href=?]', usuario_path(@usuario)

			# Proceso de salida
		delete salir_path
		assert_not estaLogeado?
		assert_redirected_to root_url
		follow_redirect!
		assert_template 'fijas/inicio'
		assert_select 'a[href=?]', acceder_path
		assert_select 'a[href=?]', salir_path, count: 0
		assert_select 'a[href=?]', usuario_path(@usuario), count: 0
	end
end
