require 'test_helper'

class GestionArchivosControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    #@imagen = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    @ruta_archivos = "public/archivos/"
    @entradas = archivos_actuales
  end




  test "should get subir" do
    get gestion_archivos_subir_url
    assert_response :success
  end

  test "Deberia guardar el archivo subido" do
    post gestion_archivos_subir_url, params: { :archivo_subida => fixture_file_upload('test/fixtures/rails.png', 'image/png') }
    
    assert_redirected_to(controller: "gestion_archivos", action: "listar", subir: "Ok")
    assert archivos_actuales.length, @entradas.length + 1
    assert archivos_actuales.last, "rails.png"
    follow_redirect!
    assert_template "gestion_archivos/listar"
    assert_not flash[:success]
  end

  test "should get listar" do
    get listar_url
    assert_response :success
  end

  test "should post borrar" do
    #imagen = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    imagen = @entradas.first
    #post gestion_archivos_borrar_url, params: { archivo_a_borrar: imagen }, xhr: true
    #assert_response :success
  end

  test "should get guardar_comentario" do
    get gestion_archivos_guardar_comentario_url
    assert_response :success
  end

  test "Debería guardar el archivo" do
  end

end
