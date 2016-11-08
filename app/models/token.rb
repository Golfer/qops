class Token < ApplicationRecord
  belongs_to :user

  before_validation :generate_api_token

  def generate_api_token(regenerate = false)
    self.api_token = SecureRandom.urlsafe_base64
    save
    # self.expiring = token_type.to_sym == :auth
    # if regenerate || !self.value || ( token_type.to_sym == :auth && (!self.expired_at || self.expired_at < Time.zone.now) )
    #   self.expired_at = Time.zone.now + 2.weeks if token_type.to_sym == :auth
    #   5.times do
    #     self.value = SecureRandom.urlsafe_base64
    #     break if valid?
    #   end
    #   save
    # end
    # self
  end
end
