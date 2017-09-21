class Relacion < ApplicationRecord
	belongs_to :seguidor, class_name: "Usuario"
	belongs_to :seguido, class_name: "Usuario"
	
		## Comprobar el uso actual de estas:
	validates :seguidor_id, presence: true
	validates :seguido_id, presence: true
end
