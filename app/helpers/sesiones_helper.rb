module SesionesHelper

		# Da acceso a un usuario
	def dar_acceso_a(usuario)
		session[:id_usuario] = usuario.id
	end

		# Devuelve el usuario logeado, si lo hay
	def usuario_actual
		@usuario_actual ||= Usuario.find_by(id: session[:id_usuario])
	end

		# Comprueba si ha accedido un usuario
	def ha_accedido?
		!usuario_actual.nil?
	end

		# Cierra la sesion del usuario
	def cerrar_acceso
		session.delete(:id_usuario)
		@usuario_actual = nil
	end
end
