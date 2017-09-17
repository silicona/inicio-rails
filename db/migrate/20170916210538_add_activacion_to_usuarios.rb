class AddActivacionToUsuarios < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :digest_activacion, :string
    add_column :usuarios, :activado, :boolean, default: false
    add_column :usuarios, :activado_en, :datetime
  end
end
