module ApplicationHelper
	def tituloCompleto(titulo_pagina = '')
		titulo_base = 'PrimeraApp'
		if titulo_pagina.empty?
			titulo_base
		else
			titulo_pagina + ' | ' + titulo_base
		end
	end

end
