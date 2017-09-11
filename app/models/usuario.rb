class Usuario < ApplicationRecord
	# Se asignan multiples microentradas para cada usuario
	has_many :microentradas

	#validacion al crear el usuario
	#validates :nombre, presence: true
	validates :email, presence: true
end
