  class User < ApplicationRecord
  has_many :roles_users
  has_many :tokens, dependent: :destroy
  has_and_belongs_to_many :roles, through: :roles_users

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :timeoutable,
         :validatable

  validates :email, presence: true, length: { maximum: 128 }
  validates :email, uniqueness: true
  validates :encrypted_password, presence: true, length: { maximum: 128 }


  attr_accessor :role, :current_password, :new_password, :confirm_password, :roles_array
  cattr_accessor :current_user

  before_validation do
    self.email = email.downcase if email.present?
  end

  after_create do
    # self.token_api_key = SecureRandom.base64.tr('+/=', 'Qrt')
    self.roles << Role.find(self.role) if self.role.present? && self.roles.empty?
  end

  scope :users_with_role, ->(role) { joins(:roles).where(roles: { name: role }) }

  #FOR checking user role
  def role?(role)
    roles.map(&:name).include?("ROLE_#{role.to_s.upcase}")
  end

  def has_roles?(role)
    roles.map(&:name).include? role
  end

  {
      admin?:     'ROLE_ADMIN',
      api?:       'ROLE_API',
      author?:    'ROLE_AUTHOR',
      reader?:    'ROLE_READER',
      moderator?: 'ROLE_MODERATOR',
      banned?: 'ROLE_BANNED'
  }.each{|name, args| define_method(name){ has_roles?(args) }}

  # def generate_token_api_key
  #   loop do
  #     token = SecureRandom.base64.tr('+/=', 'Qrt')
  #     break token unless User.exists?(token_api_key: token)
  #   end
  # end
end
