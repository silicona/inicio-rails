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
			# Simulacion si un usuario sale en otra ventana del navegador
		delete salir_path
		follow_redirect!
		assert_template 'fijas/inicio'
		assert_select 'a[href=?]', acceder_path
		assert_select 'a[href=?]', salir_path, count: 0
		assert_select 'a[href=?]', usuario_path(@usuario), count: 0
	end

	test "acceso con recordatorio" do
		dar_acceso_como(@usuario, recuerda_me: '1')
		assert_redirected_to @usuario
		assert_not_empty cookies['token_recuerda']
			# Empleo de assigns(:usuario) para probar token_recuerda
		assert_equal cookies['token_recuerda'], assigns(:usuario).token_recuerda
	end

	test "acceso sin recordatorio" do
		dar_acceso_como(@usuario, recuerda_me: '1')
		dar_acceso_como(@usuario, recuerda_me: '0')
		assert_empty cookies['token_recuerda']
	end
end
