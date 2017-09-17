class CorreoUsuarioMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.correo_usuario_mailer.activacion_cuenta.subject
  #
  def activacion_cuenta(usuario)
    @usuario = usuario
    mail to: usuario.email, subject: "Activación de cuenta en PrimeraApp"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.correo_usuario_mailer.restablecer_password.subject
  #
  def restablecer_password
    @greeting = "Hi"

    mail to: "to@example.org"
  end

    # Modificacion en config/environments/development.rb para ver los previews del mailer
    # Reiniciar el servidor de desarrollo para crear el directorio test/mailers/preview/
    # Actualizacion de test/mailers/previews/correo_usuario_mailer_preview.rb para añadir el usuario y un token_activacion
    # Modificado config/environments/test.rb para realizar los tests
end
