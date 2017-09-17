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

# Url Segura
# SecureRandom.urlsafe_base64

# a=[1,2,3]
# a.length => 3
# a.send(:length) => 3
# a.send('length') => 3
	# Empleado en el modelo Usuario#autentificado?
# usuario = Usuario.first
# usuario.digest_activacion => "$2a$10$KApqwdMeBqNSSU6jrst5HOB1YfQVzUA51jZr5TVHAX4fijndBiwoq"
# usuario.send(:digest_activacion) => "$2a$10$KApqwdMeBqNSSU6jrst5HOB1YfQVzUA51jZr5TVHAX4fijndBiwoq"
# usuario.send('digest_activacion') => "$2a$10$KApqwdMeBqNSSU6jrst5HOB1YfQVzUA51jZr5TVHAX4fijndBiwoq"
# atributo = :activacion
# usuario.send("digest_#{activacion}") => "$2a$10$KApqwdMeBqNSSU6jrst5HOB1YfQVzUA51jZr5TVHAX4fijndBiwoq"
