# Primera aplicacion con Rails

Aplicacion traducida al castellano, creada con el tutorial de rails de Michael Hartl. Puedes verlo [aquí](https://www.railstutorial.org).

Se ha completado el tutorial de Michael hartl, a falta de solucionar el Bucket S3 para subir las imagenes de las publicaciones.

Se incorporar el proyecto Chat con Action Cable, tambien de Hartl.como el dice, inspirado en:  
* [Rails5: Action CableDemo (Video)](https://medium.com/@dhh/rails-5-action-cable-demo-8bba4ccfc55e)
* [Real-Time Rails](https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable)

## Direcciones del proyecto

Github: repositorio inicio  
Heroku: https://iniciorails.herokuapp.com/  

## Apuntes varios del proyecto

Modificacion de plurales: ActiveSupport::Inflector en config/environment.rb  
* Este archivo anula el archivo config/initializers/inflections.rb
* Añadido 'password' como irregular (para el reseteo de password)

~~~
Inflections gestionados desde inflections.rb, debido a sorpresa en cap 14
~~~
  
Archivo de prueba de clases en clases.rb

### Tests

* Test de integracion Diseño_web - Apuntes en el test
* Test directos de Helpers en test/helpers/ayudantes_aplicacion_test.rb

Uso de 'debugger' en el controlador para inspeccionar variables y parametros en la vista  
	(Control + D y eliminar el debugger del controlador para continuar)  

### Debug en consola de rails
<code>
	logger = Logger.new(STDOUT)<br>
	logger.level = Logger::INFO<br>
	ActiveRecord::Base.logger = logger<br>
	<br>
	Another options for logger level are:<br>
	DEBUG, INFO, WARN, ERROR, FATAL, UNKNOWN
</code>

### Mailer
Activado el SSL para el envio de datos de forma segura:  
* En config/production.rb - config.force_SSL  
* En config/puma.rb - nuevo código  
* En ./Procfile - nuevo código  
  
Ver los [Ayudantes de rails][1] en la API de Rails.
	[1]: http://api.rubyonrails.org/v5.1/classes/ActionView/Helpers/DateHelper.html  
  
Resolver como poner las URLs en castellano (caso de usuarios/x/edit)  
	Comprobar la traduccion de metodos en los controladores - seguramente llevara a deshechar el resources de routes y crear las rutas manualmente

Procedimiento para borrar usuarios en caso de no usar JavaScript - <http://railscasts.com/episodes/77-destroy-without-javascript>

Guia de Markdown de [Joe Castro](http://joedicastro.com/pages/markdown.html)

Gema will_paginate - [Documentacion](https://github.com/mislav/will_paginate/wiki/API-documentation)
* Aplicable en el modelo de forma global
* Aplicable de forma local - equiparar en los test

~~~
Nota de Reseteo de password:  
En local, la direccion web enviada por la app no aparece escapada. En Heroku, todo correcto
~~~

Gema Faker - [Documentacion](https://github.com/stympy/faker)

Listing 13.24:  
* render @microentrada
* will_paginate @microentrada

Gema fog (de carga de imagenes)  
	IMPORTANT NOTICE:
	If there's a metagem available for your cloud provider, e.g. `fog-aws`,
	you should be using it instead of requiring the full fog collection to avoid
	unnecessary dependencies.

Gema CarrierWave:  
* Modulo CarrierWave::MiniMagick - [Documentación](http://www.rubydoc.info/github/jnicklas/carrierwave/CarrierWave/MiniMagick)  
* CarrierWave en MiniMagick - [Documentación](https://github.com/carrierwaveuploader/carrierwave#using-minimagick)


	En aplication_controller.rb, def ejecutar_sql - Metodo por probar en controlador

## AJAX

	Ver en controllers/relaciones_controller.rb

##Seguridad de Rails

Articulo sobre la [Seguridad de variables](https://aloneinthebotnet.wordpress.com/2015/11/23/seguridad-y-variables-de-entorno-en-una-aplicacion-rails/)

## CoffeeScript

Página oficial - [coffeescript.org](http://www.coffeescript.org)

Aqui hay un [corrector instalable](http://www.coffeelint.org/) de Coffee, por CoffeeLint.

##Heroku

~~~
Problema:  
El orden de usuarios difiere del orden local. (por resolver)
~~~

Introducir [variables de entorno en Heroku](https://medium.com/@MiguelCasas/variables-de-entorno-uso-en-heroku-13bd008afb19)

Mostrar las variables de entorno en Heroku:  
* Mostrar variable de entorno: <code>heroku run printenv</code>
* Comandos rails: <code>heroku run rails db:migrate --app iniciorails</code>
* Comandos pg: <code>heroku pg:reset DATABASE</code> 

####Error en Heroku:

  #####Problema en la configuracion de las columnas de la BD:
  * ActionView::Template::Error (PG::UndefinedFunction: ERROR:  operator does not exist: bigint = character varying
  * LINE 1: ...arios" INNER JOIN "relaciones" ON "usuarios"."id" = "relacio...  
                                                               ^  
  * HINT:  No operator matches the given name and argument type(s). You might need to add explicit type casts.
    * SELECT COUNT(*) FROM "usuarios" INNER JOIN "relaciones" ON "usuarios"."id" = "relaciones"."seguido_id" WHERE "relaciones"."seguidor_id" = $1):





