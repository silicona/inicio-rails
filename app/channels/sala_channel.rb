# Reiniciar el servidor despues de modificar el archivo
# Action Cable discurre en un loop que no es compatible con la autorecarga

class SalaChannel < ApplicationCable::Channel
  def subscribed
    stream_from "canal_sala"
    stream_from "canal_sala_usuario_#{usuario_chat.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
