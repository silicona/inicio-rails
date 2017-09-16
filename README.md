# Primera aplicacion con Rails

## Direcciones del proyecto

Github: repositorio inicio  
Heroku: https://iniciorails.herokuapp.com/  

## Apuntes varios del proyecto

Modificacion de plurales: ActiveSupport::Inflector en config/environment.rb  

Heroku: Migrar base de datos - heroku run rails db:migrate --app iniciorails  
  
Archivo de prueba de clases en clases.rb

~~~
Test de integracion Diseño_web  
	Apuntes en el test
~~~

~~~
Test directos de Helpers en test/helpers/ayudantes_aplicacion_test.rb
~~~

Uso de 'debugger' en el controlador para inspeccionar variables y parametros en la vista  
	(Control + D y eliminar el debugger del controlador para continuar)  

Activado el SSL para el envio de datos de forma segura:  
* En config/production.rb - config.force_SSL  
* En config/puma.rb - nuevo código  
* En ./Procfile - nuevo código  
  
Ver los [Ayudantes de rails][1] en la API de Rails.
	[1]: http://api.rubyonrails.org/v5.1/classes/ActionView/Helpers/DateHelper.html  
  
Resolver como poner las URLs en castellano (caso de usuarios/x/edit)  
	Comprobar la traduccion de metodos en los controladores - seguramente llevara a deshechar el resources de routes y crear las rutas manualmente

Procedimiento para borrar en caso de no usar JavaScript - <http://railscasts.com/episodes/77-destroy-without-javascript>

Guia de Markdown de [Joe Castro](http://joedicastro.com/pages/markdown.html)




