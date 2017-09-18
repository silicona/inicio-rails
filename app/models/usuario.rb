class Usuario < ApplicationRecord
	attr_accessor :token_recuerda, :token_activacion, :token_reseteo
	before_save :formatear_email
	before_create :crear_digest_activacion

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
											 length: { minimum: 8 },
											 allow_nil: true

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
			# Refactorizado para la activacion de usuario y reseteo de password
			# def autentificado?(token_recuerda)
			# 	return false if digest_recuerda.nil?
			# 	BCrypt::Password.new(digest_recuerda).is_password?(token_recuerda)
			# end
	def autentificado?(atributo, token)
		digest = send("digest_#{atributo}")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def olvidar
		update_attribute(:digest_recuerda, nil)
	end

		#Configuracion de Paginate en index para el modelo Usuario
	self.per_page = 10

	def activar
			#update_attribute(:activado, true)
			#update_attribute(:activado_en, Time.zone.now)
		update_columns(activado: true, activado_en: Time.zone.now)
	end

	def enviar_mail_activacion
		CorreoUsuarioMailer.activacion_cuenta(self).deliver_now
	end

		# Establece los atributos para restablecer la contraseña
	def crear_digest_reseteo
		self.token_reseteo = Usuario.nuevo_token
			#update_attribute(:digest_reseteo, Usuario.digest(token_reseteo))
			#update_attribute(:reseteo_enviado_en, Time.zone.now)
		update_columns(digest_reseteo: Usuario.digest(token_reseteo), reseteo_enviado_en: Time.zone.now)
	end

		# Envia el mail para restablecer la contraseña
	def enviar_mail_reseteo
		CorreoUsuarioMailer.restablecer_password(self).deliver_now
	end

	def reseteo_password_expirado?
		reseteo_enviado_en < 2.hours.ago
	end

	private
		def formatear_email
			self.email = email.downcase # Preferible para asegurar que el mail objetivo es el del usuario
			#email.downcase! # Equivalente al anterior, pero no mantiene la asignacion
		end

		def crear_digest_activacion
			self.token_activacion = Usuario.nuevo_token
			self.digest_activacion = Usuario.digest(token_activacion)
		end
end
