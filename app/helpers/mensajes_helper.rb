module MensajesHelper
	# Cap 6.1
	# Devuelve HTML desde el texto de entrada usando GFM
	# 	(GitHub-Flavored Markdown), maneja mejor los ejemplos
	# 	de código acotado ("fenced code")
	def markdown_en_html(texto)
		Kramdown::Document.new(texto, input: 'GFM').to_html
	end
end
