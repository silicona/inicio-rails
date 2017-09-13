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