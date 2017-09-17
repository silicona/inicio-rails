module SesionesHelper

		# Da acceso a un usuario
	def dar_acceso_a(usuario)
		session[:id_usuario] = usuario.id
	end

		# Recuerda un usuario en una sesion persistente
	def recuerda(usuario)
		usuario.recordar
		cookies.permanent.signed[:id_usuario] = usuario.id
		cookies.permanent[:token_recuerda] = usuario.token_recuerda
	end

		# Devuelve true si el usuario es el usuario_actual
	def usuario_actual?(usuario)
		usuario == usuario_actual
	end

		# Devuelve el usuario logeado o de sesion persistente, si lo hay
	def usuario_actual
		if (id_usuario = session[:id_usuario])
			@usuario_actual ||= Usuario.find_by(id: id_usuario)
		elsif (id_usuario = cookies.signed[:id_usuario])
			#raise # Error provocado para la prueba de test/helpers/sesiones_helper_test.rb
			usuario = Usuario.find_by(id: id_usuario)
			if usuario && usuario.autentificado?(:recuerda, cookies[:token_recuerda])
				dar_acceso_a usuario
				@usuario_actual = usuario
			end
		end
	end

		# Comprueba si ha accedido un usuario
	def ha_accedido?
		!usuario_actual.nil?
	end

		# Olvida la sesión persistente del usuario
	def olvidar(usuario)
		usuario.olvidar if ha_accedido?
		cookies.delete(:id_usuario)
		cookies.delete(:token_recuerda)
	end

		# Cierra la sesion del usuario
	def cerrar_acceso
		olvidar(usuario_actual)
		session.delete(:id_usuario)
		@usuario_actual = nil
	end

		# Redirige a la URL deseada o a la de defecto
	def redirigir_a_URL_o(defecto)
		redirect_to(session[:url_deseada] || defecto)
		session.delete(:url_deseada)
	end

		# Guarda la URL a la que intenta acceder
	def guardar_URL
		session[:url_deseada] = request.original_url if request.get?
	end
end
