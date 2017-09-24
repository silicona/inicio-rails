require 'test_helper'

class MensajesControllerTest < ActionDispatch::IntegrationTest
  # test "should get index" do
  #   get mensajes_index_url
  #   assert_response :success
  # end

  # test "should get create" do
  #   get mensajes_create_url
  #   assert_response :success
  # end

  def setup
  	@usuario = usuarios(:paco)
  end

  test "Debería acceder al chat" do
  	dar_acceso_como @usuario
  	get mensajes_url
  	assert_response 200
  end

  test "El chat debería requerir acceso" do
  	get mensajes_url
  	assert_redirected_to acceder_url
  end

 	test "Debería hacer un mensaje válido" do
 		dar_acceso_como @usuario
 		post mensajes_url, params: { mensaje: { contenido: "Contenido válido" } }, xhr: true
 		assert_response :success
 	end

  test "Debería gestionar los mensajes invalidos" do
  	dar_acceso_como @usuario
  	post mensajes_url, params: { mensaje: { contenido: "" } }, xhr: true
  	assert_response :success
  end


end
