class Usuario
	attr_accessor :nombre, :email, :digest

	def initialize(atributos = {})
		@nombre = atributos[:nombre]
		@email = atributos[:email]
		@digest = atributos[:digest] || (0..15).map {(65 + rand(26)).chr.downcase}.join
	end

	def emailConFormato
		"#{@nombre} <#{@email}>"
	end
end

######################################
######################################
# Ejecutando en consola:

# Convierte strings en un array:
# %w[foo bar baz] => ["foo", "bar", "baz"]

# direcciones = %w[miemail2jaja.com soyunico@mail.com pepe@mail.com]
# 	direcciones.each do |direccion|
# 	puts direccion
# end


# Apartado Flash
# flash = { exito: "Funciona", error: "Fracaso"}
# flash.each do |llave, valor|
# 	puts "#{llave}"
# 	puts "#{valor}"
# end

