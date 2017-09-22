# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#bienvenida_doble = (frase) -> alert(frase + " " + frase)
#bienvenida_doble('hola mundillo!');

#poner_anexo = -> 
#	$('#mensajes_tabla').append('hola Mundillo')
#$(document).on('turbolinks:load', poner_anexo);

apuntador = (contenido) ->
  $('#mensajes_tabla').append contenido

$(document).on 'turbolinks:load', (evento) =>
  apuntador "Hola Apuntador" 


