class Role < ApplicationRecord
  has_many :roles_users
  has_and_belongs_to_many :users, through: :roles_users#, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 64 }
  validates :name, uniqueness: true
end
