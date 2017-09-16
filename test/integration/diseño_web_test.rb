require 'test_helper'

class DiseñoWebTest < ActionDispatch::IntegrationTest
  setup do
    @usuario = usuarios(:paco)
  end

  test "diseño de enlaces en root" do
		get root_url
		assert_template "fijas/inicio" # Confirma que llegamos a la vista de Inicio
		assert_select "a[href=?]", root_path, count: 2  	
		assert_select "a[href=?]", sos_path  	
		assert_select "a[href=?]", contacto_path  	
    assert_select "a[href=?]", acerca_path
		assert_select "a[href=?]", acceder_path
    dar_acceso_como	@usuario
    get root_url
    assert_template "fijas/inicio"
    assert_select "a[href=?]", acceder_path, count: 0
    assert_select "a[href=?]", usuarios_path
    assert_select "a[href=?]", "#", text: "Tu cuenta"
    assert_select "a[href=?]", usuario_path(@usuario)
    assert_select "a[href=?]", edit_usuario_path(@usuario)
    assert_select "a[href=?]", salir_path
  end

  test "Diseño de enlaces en ayuda" do
  	get sos_url
  	assert_template "fijas/ayuda"
  	assert_select "a[href=?]", root_path
  end

  # Añadido include ApplicationHelper en test/test_helper.rb
  #   para incluir los metodos de app/helpers/application_helper.rb en los tests
  test "Diseño de web - Title" do
  	get contacto_path
  	assert_select 'title', tituloCompleto("Contacto")
  end
end

# assert_select "div" 													<div>foobar</div>
# assert_select "div", "foobar" 								<div>foobar</div>
# assert_select "div.nav" 											<div class="nav">foobar</div>
# assert_select "div#profile" 									<div id="profile">foobar</div>
# assert_select "div[name=yo]" 									<div name="yo">hey</div>
# assert_select "a[href=?]", ’/’, count: 1 			<a href="/">foo</a>
# assert_select "a[href=?]", ’/’, text: "foo"		<a href="/">foo</a>