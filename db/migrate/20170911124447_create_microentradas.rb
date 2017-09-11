class CreateMicroentradas < ActiveRecord::Migration[5.0]
  def change
    create_table :microentradas do |t|
      t.text :contenido
      t.integer :usuario_id

      t.timestamps
    end
  end
end
