require 'test_helper'

class UsuariosControllerTest < ActionDispatch::IntegrationTest
  test "should get nuevo" do
    get registro_url
    assert_response :success
    assert_select 'title', tituloCompleto('Registro')
  end

end
