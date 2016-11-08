class AddRoles < ActiveRecord::Migration[5.0]
  def self.up
    Role.create(name: 'ROLE_ADMIN').users
    Role.create(name: 'ROLE_API').users
    Role.create(name: 'ROLE_MODERATOR').users
    Role.create(name: 'ROLE_AUTHOR').users
    Role.create(name: 'ROLE_READER').users
    Role.create(name: 'ROLE_BANNED').users
  end

  def self.down
    Role.find_by_name('ROLE_ADMIN').delete
    Role.find_by_name('ROLE_API').delete
    Role.find_by_name('ROLE_MODERATOR').delete
    Role.find_by_name('ROLE_AUTHOR').delete
    Role.find_by_name('ROLE_READER').delete
    Role.find_by_name('ROLE_BANNED').delete
  end
end
