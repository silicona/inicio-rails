
# class Palabra < String
# 	def palindromo?(string)
# 		string == string.reverse
# 	end

# 	def soy_palindramo?
# 		self == self.reverse
# 		#self == reverse
# 	end

# 	def length
# 		"Tengo #{self.length} caracteres"
# 	end
# end

# class String
# 	def string_palindromo?
# 		self == self.reverse
# 	end

# 	def barajear
# 		self.split('').to_a.shuffle.join
# 	end

# end


# w = Palabra.new
# puts "foobar: " + w.palindromo?('foobar').to_s

# w = Palabra.new('abracacabra')

# puts "soy: " + w.soy_palindramo?.to_s

# e = "deified".string_palindromo?.to_s
# puts "deified es un string palindromo: " + e

# e = "foobar".barajear
# puts "barajear: " + e

# puts "Clase usuario"

# class Usuario_prueba
# 	attr_accessor :nombre, :email, :digest

# 	def initialize(atributos = {})
# 		@nombre = atributos[:nombre]
# 		@email = atributos[:email]
# 		@digest = atributos[:digest] || (0..15).map {(65 + rand(26)).chr.downcase}.join
# 	end

# 	def ver
# 		inspect
# 	end

# 	def emailConFormato
# 		"#{@nombre} <#{@email}>"
# 	end
# end

# usuario = Usuario_prueba.new
# puts "Usuario: " + usuario.ver
# usuario_con_datos = Usuario_prueba.new(nombre: "Pepe", email: "miemail@dominio.com", digest: "mi propio digest")
# puts "Con datos: " + usuario_con_datos.ver
# puts "Digest: " + usuario_con_datos.digest
# puts "Con formato:", usuario_con_datos.emailConFormato

	### De apartado Seguir y dejar de seguir ###
	# arrays siguiendo y seguidores
# Usuario.first.seguidores.count
# Usuario.first.seguidores.to_a.count
# Usuario.first.siguiendo.map(&:id)


######################################
######################################
# Ejecutando en consola:

# puts "Bloques".upcase
# (1..5).each { |i| puts 2 * i }
# "=> 1..5"

# (1..5).each do |i|
# 	puts 2 * i
#   puts '--'
# end
# a.push(6)                  # Pushing 6 onto an array
# => [42, 8, 17, 6]
# a << 7                     # Pushing 7 onto an array
# => [42, 8, 17, 6, 7]
# a << "foo" << "bar"        # Chaining array pushes
# => [42, 8, 17, 6, 7, "foo", "bar"]

# ('a'..'e').to_a
# => ["a", "b", "c", "d", "e"]

# Convierte strings en un array:
# %w[foo bar baz] => ["foo", "bar", "baz"]

# direcciones = %w[miemail2jaja.com soyunico@mail.com pepe@mail.com]
# 	direcciones.each do |direccion|
# 	puts direccion
# end

# 3.times { puts "Betelgeuse!" }   # 3.times takes a block with no variables.
# "Betelgeuse!"
# "Betelgeuse!"
# "Betelgeuse!"
# => 3
# (1..5).map { |i| i**2 }          # The ** notation is for 'power'.
# => [1, 4, 9, 16, 25]
# %w[a b c]                        # Recall that %w makes string arrays.
# => ["a", "b", "c"]
# %w[a b c].map { |char| char.upcase }
# => ["A", "B", "C"]
# %w[A B C].map { |char| char.downcase }
# => ["a", "b", "c"]

# As you can see, the map method returns the result of applying the given block to each element in the array or range. In the final two examples, the block inside map involves calling a particular method on the block variable, and in this case there’s a commonly used shorthand called “symbol-to-proc”:

# %w[A B C].map { |char| char.downcase }
# => ["a", "b", "c"]
# %w[A B C].map(&:downcase)
# => ["a", "b", "c"]

# Cadena aleatoria
# ('a'..'z').to_a.shuffle[0..7].join

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

# Escritura Lambda - funcion sin nombre
# -> { puts "foo"}
# 	=> #<Proc:0x....
# 	# Evaluar la funcion
# -> { puts "foo" }.call
# 	foo
# 	=> nil