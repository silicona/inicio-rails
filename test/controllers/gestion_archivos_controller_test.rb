require 'test_helper'

class GestionArchivosControllerTest < ActionDispatch::IntegrationTest
  test "should get subir" do
    get gestion_archivos_subir_url
    assert_response :success
  end

  test "should get listar" do
    get gestion_archivos_listar_url
    assert_response :success
  end

  test "should get borrar" do
    get gestion_archivos_borrar_url
    assert_response :success
  end

  test "should get guardar_comentario" do
    get gestion_archivos_guardar_comentario_url
    assert_response :success
  end

end
