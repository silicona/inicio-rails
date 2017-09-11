class Microentrada < ApplicationRecord
	# Se asigna el modelo a Usuario
	belongs_to :usuario

	#validacion al crear la microentrada
	validates :contenido, length: {maximum: 140},
												presence: true
	validates :usuario_id, presence: true
end
