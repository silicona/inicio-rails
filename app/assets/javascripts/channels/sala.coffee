App.sala = App.cable.subscriptions.create "SalaChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log("data:  %o", data)
    if data.mention
      alert("Tienes una mencion de " + data.autor)

    if(data.mensaje && !data.mensaje.blank?)
      # console.log "Dentro"
      $('#mensajes_tabla').append data.mensaje
      desplazar_pantalla()

      # $('#mensajes_tabla').append '<div class="mensaje"><div class="mensaje_usuario">' + data.nombre + ": " + '</div><div class="mensaje_contenido">' + data.contenido + '</div></div>'

$(document).on 'turbolinks:load', ->
  enviar_mensaje()
  desplazar_pantalla()

enviar_mensaje = () ->
  $('#mensaje_contenido').on 'keydown', (evento) ->
    if evento.keyCode is 13 && !evento.Shift
      $('input').click()  
      evento.target.value = ""  # borra el valor de la casilla 
      evento.preventDefault()   # evita crear una nueva linea

desplazar_pantalla = () ->
  $('#mensajes').scrollTop($('#mensajes')[0].scrollHeight)