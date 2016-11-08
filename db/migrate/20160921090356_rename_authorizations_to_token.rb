class RenameAuthorizationsToToken < ActiveRecord::Migration[5.0]
  def up
    rename_table :authorizations, :tokens
    add_column :tokens, :expiring, :boolean, default: false
    add_column :tokens, :expired_at, :datetime
    add_column :tokens, :api_token, :string
    add_column :tokens, :api_salt, :string
    add_index :tokens, :api_token, unique: true
    add_index :tokens, :token, unique: true
  end

  def down
    remove_index :tokens, :token
    remove_index :tokens, :api_token
    remove_column :tokens, :api_token
    remove_column :tokens, :api_salt
    remove_column :tokens, :expiring
    remove_column :tokens, :expired_at
    rename_table :tokens, :authorizations
  end
end
