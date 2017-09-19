class CreateMicroentradas < ActiveRecord::Migration[5.1]
  def change
    create_table :microentradas do |t|
      t.text :contenido
      t.references :usuario, foreign_key: true

      t.timestamps
    end
    add_index :microentradas, [:usuario_id, :created_at]
  end
end
