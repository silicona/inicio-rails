class GestionArchivosController < ApplicationController

	RutaArchivos = 'public/archivos/'
	RutaComentarios = 'public/comentarios/comentarios.txt'

  def subir
  	@formato_erroneo = false
  	if request.post?
  			# Archivo subido por el usuario
  		archivo = params[:archivo_subida]
  			# Nombre original del archivo
  		nombre = archivo.original_filename
  			# Directorio de la subida
  		directorio = RutaArchivos
  			# Obtener la extensión del archivo
  		extension = nombre.slice(nombre.rindex("."), nombre.length).downcase
  			# Comprueba la extensión correcta
  		if extension == ".pdf" or extension == ".doc" or extension == ".docx"
  			ruta = File.join(directorio, nombre)
  				# Creación del archivo
  			resultado = File.open(ruta, "wb") { |f| f.write(archivo.read) }
  				# Verifica la subida
  			if resultado
  				subir = "Ok"
  			else
  				subir = "Fracaso"
  			end
  				# Redirige con la variable GET subir
  			redirect_to(controller: "gestion_archivos", action: "listar", subir: subir)
  		else
  			@formato_erroneo = true
  		end
  	end
  end

  def listar
  		# obtenemos la lista del directorio
  	@archivos = Dir.entries(RutaArchivos)
  		# Mensaje que muestra si la pagina viene de otra opcion
  	@mensaje = ""
  		# Comprueba la variable GET subir
  	if params[:subir].present?
  		if params[:subir] == "Ok"
  			@mensaje = "El archivo se ha subido con exito"
  		else
  			@mensaje = "Ha habido un problema con la subida"
  		end
  	end
  		# Comprueba la variable GEt eliminar
  	if params[:eliminar].present?
  		if params[:eliminar] == "Ok"
  			@mensaje = "El archivo se ha eliminado con éxito"
  		else
  			@mensaje = "El archivo no se ha podido elliminar"
  		end
  	end

  	if File.exist?(RutaComentarios)
  		@comentarios = File.read(RutaComentarios)
  	else
  		@comentarios = ""
  	end
  end

  def borrar
  		# Recuperamos el nombre del archivo
  	archivo = params[:archivo_a_borrar]
  	ruta_al_archivo = RutaArchivos + archivo
  		# Verificamos que el archivo existe
  	if File.exist?(ruta_al_archivo)
  			# Se intenta borrar
  		resultado = File.delete(ruta_al_archivo)
  	else
  			# El archivo no existe
  		resultado = false
  	end
  		# Verificacion del borrado
  	if resultado
  		eliminado = "Ok"
  	else
  		eliminado = "Error"
  	end
  	redirect_to controller: "gestion_archivos", action: "listar", eliminar: eliminado

  end

  def guardar_comentario
  		# Guarda los comentario de POST
  	if request.post?
  			# Guarda en una variablw
  		comentarios = params[:comentarios]
  			# Abre al archivo de comentarios. Si no existe, se crea
  		File.open(RutaComentarios, "wb"){ |f|
  			f.write(comentarios)
  				# Se cierra el archivo para libera memoria
  			f.close()	
  		}
  	end
  		# Verifica si existe el archivo de comentarios
  	if File.exist?(RutaComentarios)
  			# Guarda el contenido del archivo
  		@comentarios = File.read(RutaComentarios)
  	else
  			# No existe el archivo. Se guardan las comillas
  		@comentario = ""
  	end

  end
end
