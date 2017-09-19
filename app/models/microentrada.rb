class Microentrada < ApplicationRecord
  belongs_to :usuario
  	# Establece el orden en que se reciben los elementos de la BD
  default_scope -> { order(created_at: :desc) }

  	# Metodo de referencia al cargador de imágenes
  mount_uploader :imagen, ImagenUploader

  validates :usuario_id, presence: true

  validates :contenido, presence: true, 
  											length: { maximum: 140 }

  self.per_page = 15

  validate :peso_de_imagen

  private

  		#Validación del tamaño de la imagen
  	def peso_de_imagen
  		if imagen.size > 5.megabytes
  			errors.add(:imagen, "debería ser menor de 5MB")
  		end
  	end

end
