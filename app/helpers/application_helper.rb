module ApplicationHelper
	def tituloCompleto(titulo_pagina = '')
		titulo_base = 'PrimeraApp'
		if titulo_pagina.empty?
			titulo_base
		else
			titulo_pagina + ' | ' + titulo_base
		end
	end

	def enlace_a(nombre, enlace, opciones = {})
		link_to(nombre, enlace, opciones)
	end

end
