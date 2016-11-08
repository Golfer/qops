class CreateRolesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :roles_users do |t|
      t.references :user, index: true, null: false
      t.references :role, index: true, null: false
    end

    add_index :roles_users, %i(user_id role_id), unique: true
  end
end
