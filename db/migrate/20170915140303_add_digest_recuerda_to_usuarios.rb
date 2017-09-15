class AddDigestRecuerdaToUsuarios < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :digest_recuerda, :string
  end
end
