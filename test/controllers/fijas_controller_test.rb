require 'test_helper'

class FijasControllerTest < ActionDispatch::IntegrationTest
  setup do
  	@titulo_base = 'PrimeraApp'
  end

  test "Debería llegar al root" do
  	get root_url
  	assert_response 200
  end

  test "should get inicio" do
    get fijas_inicio_url
    assert_response :success
    assert_select 'title', "Inicio | #{@titulo_base}"
  end

  test "should get inicio por path" do
    get fijas_inicio_path
    assert_response :success
  end

  test "should get ayuda" do
    get fijas_ayuda_url
    assert_response :success
    assert_select 'title', "Ayuda | #{@titulo_base}"
  end

  test "Deberia llegar a Acerca de nosotras por get" do
  	get fijas_acerca_url
  	assert_response 200
  end

  test "Debería llegar a Contacto por get" do
  	get fijas_contacto_url
  	assert_response 200
  	assert_select 'title', "Contacto | #{@titulo_base}"
  end

end
