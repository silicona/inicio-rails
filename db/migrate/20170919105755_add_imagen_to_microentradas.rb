class AddImagenToMicroentradas < ActiveRecord::Migration[5.1]
  def change
    add_column :microentradas, :imagen, :string
  end
end
