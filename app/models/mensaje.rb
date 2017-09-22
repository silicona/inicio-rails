class Mensaje < ApplicationRecord
	belongs_to :usuario
	validates :contenido, presence: true
	scope :para_mostrar, -> { order(:created_at).last(50)}
end
