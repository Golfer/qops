class AddBasicAdminUsers < ActiveRecord::Migration[5.0]
  def self.up
    User.create email: 'admin@mail.com', password: '123123', role: Role.find_by_name('ROLE_ADMIN')
    User.create email: 'moderator@mail.com', password: '123123', role: Role.find_by_name('ROLE_MODERATOR')
    User.create email: 'api@mail.com', password: '123123', role: Role.find_by_name('ROLE_API')
    User.create email: 'author@mail.com', password: '123123', role: Role.find_by_name('ROLE_AUTHOR')
    User.create email: 'reader@mail.com', password: '123123', role: Role.find_by_name('ROLE_READER')
  end

  def self.down
    User.find_by_email('admin@mail.com').delete
    User.find_by_email('moderator@mail.com').delete
    User.find_by_email('api@mail.com').delete
    User.find_by_email('author@mail.com').delete
    User.find_by_email('reader@mail.com').delete
  end
end
