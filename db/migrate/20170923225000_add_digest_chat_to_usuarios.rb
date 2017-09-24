class AddDigestChatToUsuarios < ActiveRecord::Migration[5.1]
  def change
  	add_column :usuarios, :digest_chat, :string
  end
end
