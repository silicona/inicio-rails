require 'test_helper'

class CorreoUsuarioMailerTest < ActionMailer::TestCase
  
    # Modificado config/environments/test.rb
  test "activacion_cuenta" do
    usuario = usuarios(:paco)
    usuario.token_activacion = Usuario.nuevo_token
    mail = CorreoUsuarioMailer.activacion_cuenta(usuario)
    assert_equal "Activación de cuenta en PrimeraApp", mail.subject
    assert_equal [usuario.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match usuario.nombre, mail.body.encoded
    assert_match usuario.token_activacion, mail.body.encoded
    assert_match CGI.escape(usuario.email), mail.body.encoded
  end

  test "restablecer_password" do
    # usuario = usuarios(:paco)
    # usuario.token_reset = Usuario.nuevo_token
    # mail = CorreoUsuarioMailer.restablecer_password(usuario)
    # assert_equal "Restablecer password", mail.subject
    # assert_equal [usuario.email], mail.to
    # assert_equal ["noreply@example.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  end

end
