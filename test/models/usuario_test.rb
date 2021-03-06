require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
	setup do
		@usuario = Usuario.new(nombre: "Paco", 
													 email: "miemail@mail.com",
													 password: "password",
													 password_confirmation: "password")
		@user_sin_pass = Usuario.new(nombre: "Pepe", email: "miemail@gege.com", password: "pepe")
	end

	test "Debería ser válido" do
		assert @usuario.valid?
	end

	test "No debería ser válido" do
		assert_not @user_sin_pass.valid?
	end

	test "El usuario deberia tener nombre" do
		@usuario.nombre = "  "
		assert_not @usuario.valid?
	end

	test "El usuario debería tener email" do
		@usuario.email = "  "
		assert_not @usuario.valid?
	end

	test "El nombre de usuario no debería ser muy largo" do
		@usuario.nombre = "a"*51
		assert_not @usuario.valid?
	end

	test "El email no debería ser kilométrico" do
		@usuario.email = "a"*200 + "@miemail.com"
		assert_not @usuario.valid?
	end

	test "Se deberían de aceptar estas direcciones email" do
		direcciones = %w[miemail@mail.com tu+email@mail.com el-detupadre@jaja.com]
		direcciones.each do |direccion|
			@usuario.email = direccion
			assert @usuario.valid?, "#{direccion.inspect} debería ser válida"
		end
	end

	test "La validación de email debería rechazar las direcciones invalidas" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com lamia@email..com]
    invalid_addresses.each do |invalid_address|
      @usuario.email = invalid_address
      assert_not @usuario.valid?, "#{invalid_address.inspect} debería ser inválida"
    end
  end

  test "La dirección email debería ser única" do
  	usuario_duplicado = @usuario.dup
  	usuario_duplicado.email = @usuario.email.upcase
  	@usuario.save
  	assert_not usuario_duplicado.valid?
  end

  test "El email se debería guardar en minúsculas" do
  	email_prueba = "ProdfoRF@MimitoS.Com"
  	@usuario.email = email_prueba
  	@usuario.save
  		# reload trae un valor grabado en la base de datos
  	assert_equal email_prueba.downcase, @usuario.reload.email
  end

  test "La contraseña no debería estar vacía" do
  	@usuario.password = @usuario.password_confirmation = " " * 9
  	assert_not @usuario.valid?
  end

  test "La contraseña debería tener 8 caracteres como mínimo" do
  	@usuario.password = @usuario.password_confirmation = "a" * 7
  	assert_not @usuario.valid?
  end

  test "autentificado? debería retornar falso para un usuario con digest = nil" do
  	assert_not @usuario.autentificado?(:recuerda, '')
  end

  #############################################################
  	# Test de microentradas relacionadas con el usuario
  #############################################################

  test "Las entradas del usuario deberían destruirse al borrar el usuario" do
  	@usuario.save
  	@usuario.microentradas.create!(contenido: "Entrada agazapada")
  	assert_difference "Microentrada.count", -1 do
  		@usuario.destroy
  	end
  end

  ########################################

    # Test de seguidores

  test "Debería seguir y dejar de seguir a otro usuario" do
    @paco = usuarios(:paco)
    @shilum = usuarios(:shilum)
    assert_not @paco.siguiendo?(@shilum)

    @paco.seguir(@shilum)
    assert @paco.siguiendo?(@shilum)
    assert @shilum.seguidores.include?(@paco)

    @paco.dejar_de_seguir(@shilum)
    assert_not @paco.siguiendo?(@shilum)
    
      # Seguirse s una misma
    @paco.seguir(@paco)
    assert @paco.siguiendo?(@paco)
    assert @paco.seguidores.include?(@paco)
  end

  test "Lo publicado debería tener las entradas correctas" do
    paco = usuarios(:paco)
    shilum = usuarios(:shilum)
    clara = usuarios(:clara)
    assert_not clara.microentradas.empty?
    clara.microentradas.each do |entradas_seguido|
      assert paco.publicado.include?(entradas_seguido)
    end

    paco.microentradas.each do |entradas_propias|
      assert paco.publicado.include?(entradas_propias)
    end

    shilum.microentradas.each do |entradas_ajenas|
      assert_not paco.publicado.include?(entradas_ajenas)
    end
  end
end
