class Usuario < ApplicationRecord
	before_save { self.email = email.downcase } # Preferible para asegurar que el mail objetivo es el del usuario
	# before_save { email.downcase! } # Equivalente al anterior before_save
	attr_accessor :token_recuerda 

	#RegexpEmail = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	RegexpEmail = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	
	validates :nombre, presence: true,
										 length: { maximum: 50 }
	
	validates :email, presence: true,
										length: { maximum: 50 },
										format: { with: RegexpEmail },
										uniqueness: { case_sensitive: false }

	has_secure_password		
		# Inicia el sistema de autentificación, que incluye una columna password_digest en la BD.
		# Incluye los atributos virtuales Password y password_confirmation y el método authenticate
		# Necesita gema bcrypt en gemfile

	validates :password, presence: true,
											 length: { minimum: 8 }

	class << self # self se refiere a la clase Usuario - Modo ExtraConfuso
			# Devuelve el digest del string
		#def Usuario.digest(string) # Modo Claro
		#def self.digest(string) # self se refiere a la clase Usuario - Modo Confuso
		def digest(string) # Igual - Modo extraConfuso
			coste = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: coste)
		end

			# Crea un string aleatorio para usar como token
		#def Usuario.nuevo_token # Modo Claro
		#def self.nuevo_token # self se refiere a la clase Usuario - Modo Confuso
		def nuevo_token # Igual - Modo ExtraConfuso
			SecureRandom.urlsafe_base64
		end
	end

		# Crea el token_recuerda y almacena su digest en la BD para las sesiones persistentes
	def recordar
		self.token_recuerda = Usuario.nuevo_token
		update_attribute(:digest_recuerda, Usuario.digest(token_recuerda))
	end

		# Devuelve true si el token coincide con el digest correspondiente
	def autentificado?(token_recuerda)
		return false if digest_recuerda.nil?
		BCrypt::Password.new(digest_recuerda).is_password?(token_recuerda)
	end

	def olvidar
		update_attribute(:digest_recuerda, nil)
	end

end
