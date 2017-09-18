# Preview all emails at http://localhost:3000/rails/mailers/correo_usuario_mailer
class CorreoUsuarioMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/correo_usuario_mailer/activacion_cuenta
  def activacion_cuenta
  	usuario = Usuario.first
  	usuario.token_activacion = Usuario.nuevo_token
    CorreoUsuarioMailer.activacion_cuenta(usuario)
  end

  # Preview this email at http://localhost:3000/rails/mailers/correo_usuario_mailer/restablecer_password
  def restablecer_password
    usuario = Usuario.first
    usuario.token_reseteo = Usuario.nuevo_token
    CorreoUsuarioMailer.restablecer_password(usuario)
  end

end
