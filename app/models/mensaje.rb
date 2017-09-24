class Mensaje < ApplicationRecord
	belongs_to :usuario
	validates :contenido, presence: true
	scope :para_mostrar, -> { order(:created_at).last(50) }

		# Devuelve una lista de usuarios mencionados
	def menciones
		contenido.scan(/@(#{Usuario::RegexNombre})/).flatten.map do |mencion|
			Usuario.find_by(nombre: mencion)
		end.compact
	end
end
