module UsuariosHelper
	#def gravatarPara(usuario, opciones = { medida: 50 })
	def gravatarPara(usuario, medida: 50)
			# Las URLs de Gravatar se basan en un hash MD5.
			# En ruby, MD5 se implementa con el método hexdigest de la libreria Digest
		gravatar_id = Digest::MD5::hexdigest(usuario.email.downcase)
		#medida = opciones[:medida]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{medida}"
		image_tag(gravatar_url, alt: usuario.nombre, class: "gravatar")
	end
end
