class Usuario < ApplicationRecord
	#before_save { self.email = email.downcase }
	before_save { email.downcase! } # Equivalente al anterior before_save

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

end
