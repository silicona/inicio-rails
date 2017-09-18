class AddReseteoToUsuarios < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :digest_reseteo, :string
    add_column :usuarios, :reseteo_enviado_en, :datetime
  end
end
