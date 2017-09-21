require 'test_helper'

class UsuariosControllerTest < ActionDispatch::IntegrationTest
  
  setup do
  	@usuario = usuarios(:paco)
  	@otro_usuario = usuarios(:shilum)
  	@tercer_usuario = usuarios(:clara)
  end

  test "Debería llegar al registro" do
    get registro_url
    assert_response :success
    assert_select 'title', tituloCompleto('Registro')
  end

  test "Debería redirigir desde index a acceder si el usuario no ha accedido" do
  	get usuarios_path
  	assert_redirected_to acceder_url
  end

  test "No debería permitir que el atributo admin sea editable por la web" do
  	dar_acceso_como @otro_usuario
  	assert_not @otro_usuario.admin?
  	patch usuario_path(@otro_usuario), params: { usuario: { password: "password",
  																													password_confirmation: "password",
  																													admin: true } }
  	assert_not @otro_usuario.reload.admin?
  end

  test "Debería redirigir desde destruir si no se ha accedido" do
  	assert_no_difference 'Usuario.count' do
  		delete usuario_path(@otro_usuario)
  	end
  	assert_redirected_to acceder_url
  end

  test "Debería redirigir desde destruir si el usuario no es admin" do
  	dar_acceso_como @otro_usuario
  	assert_no_difference 'Usuario.count' do
  		delete usuario_path(@tercer_usuario)
  	end
  	assert_redirected_to root_url
  end

  test "El index debería contener la paginacion y los enlaces de borrar si usuario_actual es admin" do
  	dar_acceso_como @usuario
  	get usuarios_path
  	assert_template "usuarios/index"
  	assert_select "div.pagination"
  	primera_pagina = Usuario.paginate(page: 1, per_page: 10)
  	primera_pagina.each do |usuario|
  		assert_select "a[href=?]", usuario_path(usuario), text: usuario.nombre
  		unless usuario.admin == true
  			assert_select "a[href=?]", usuario_path(usuario), method: :delete, text: "Borrar usuario"
  		end
  	end
  	assert_difference 'Usuario.count', -1 do
  		delete usuario_path(@otro_usuario)
  	end
  end

  test "El index como no-admin no debería tener enlaces de borrar" do
  	dar_acceso_como @otro_usuario
  	get usuarios_path
  	assert_select "a", text: "Borrar usuario", count: 0
  end

  test "Debería borrar a un usuario si el usuario_actual es admin" do
  	dar_acceso_como @usuario
  	get usuarios_path
  	assert_select "a", text: "Borrar usuario"
  	assert_difference 'Usuario.count', -1 do
  		delete usuario_path(@otro_usuario)
  	end
  end

  ##################################################################

    # Seguir y dejar de seguir

  test "Debería redirigir desde Siguiendo si no ha accedido" do
    get siguiendo_usuario_path(@usuario)
    assert_redirected_to acceder_path
  end

  test "Debería redirigir desde Seguidores si no ha accedido" do
    get seguidores_usuario_path(@usuario)
    assert_redirected_to acceder_path
  end

end
