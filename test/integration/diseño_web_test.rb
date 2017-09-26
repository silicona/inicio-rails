require 'test_helper'

class DiseñoWebTest < ActionDispatch::IntegrationTest
  setup do
    @usuario = usuarios(:paco)
    @ruta_test = "/test/"
    @entradas = archivos_actuales
  end

  test "diseño de enlaces en root" do
		get root_url
		assert_template "fijas/inicio" # Confirma que llegamos a la vista de Inicio
		assert_select "a[href=?]", root_path, count: 2  	
		assert_select "a[href=?]", sos_path  	
		assert_select "a[href=?]", contacto_path  	
    assert_select "a[href=?]", acerca_path
    assert_select "a[href=?]", acceder_path
		assert_select "a[href=?]", listar_path
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

  test "Diseño web de Gestion de archivos - Listar" do
    get listar_path
    archivos = assigns(:archivos)
    assert_select "a[href=?]", gestion_archivos_subir_path, text: "Subir archivo"
    #assert_not archivos.empty?
      archivos.each do |archivo|
        ruta = "/archivos/" + archivo
        assert_select 'a[href=?]', ruta, text: "Ver archivo"
        assert_select "a[href=?]", gestion_archivos_borrar_path + "?archivo_a_borrar=" + archivo, text: "Borrar archivo"
      end
    
    assert_select "a[href=?]", 
                  "https://fernando-gaitan.com.ar/ruby-on-rails-parte-9-subir-y-trabajar-con-archivos/", 
                  "Web de Fernando Gaitan"
    assert_select "a[href=?]", gestion_archivos_guardar_comentario_path, "Agregar comentarios"
  end

  test "Deberia subir y borrar archivos" do
    entradas = archivos_actuales
    post gestion_archivos_subir_path, params: { :archivo_subida => fixture_file_upload('test/fixtures/rails.png') }
    assert_redirected_to listar_path + "?subir=Ok"
    follow_redirect!
    assert_template "gestion_archivos/listar"
    assert_select "li.archivo", count: entradas.length + 1
    assert_select "a[href=?]", gestion_archivos_borrar_path + '?archivo_a_borrar=rails.png', text: "Borrar archivo"
    post gestion_archivos_borrar_path + '?archivo_a_borrar=rails.png'
    assert_redirected_to listar_path + "?eliminar=Ok"
    follow_redirect!
    assert_template "gestion_archivos/listar"
    assert_select "li.archivo", count: entradas.length
    #assert archivos_actuales
  end

  test "Diseño de guardar comentario" do
    get gestion_archivos_guardar_comentario_path
    assert_response 200
    assert_template "gestion_archivos/guardar_comentario"
    assert_select "form", count:1
    assert_select "textarea", count: 1
    assert_select "input[value=?]", "Guardar comentario"
    assert_select "a[href=?]", listar_path, text: "Volver a la lista de archivos"
  end

  test "Deberia llegar a listar los archivos" do
    get root_url
    assert_select "a[href=?]", listar_path
    get listar_path
    assert_response 200
    assert_template "gestion_archivos/listar"
  end

  



end

# assert_select "div" 													<div>foobar</div>
# assert_select "div", "foobar" 								<div>foobar</div>
# assert_select "div.nav" 											<div class="nav">foobar</div>
# assert_select "div#profile" 									<div id="profile">foobar</div>
# assert_select "div[name=yo]" 									<div name="yo">hey</div>
# assert_select "a[href=?]", ’/’, count: 1 			<a href="/">foo</a>
# assert_select "a[href=?]", ’/’, text: "foo"		<a href="/">foo</a>