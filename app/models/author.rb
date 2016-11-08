#need to delete because I create Table User/ Added role permision for user. And I think we do not need this model and table
class Author < ApplicationRecord
  has_many :quotations, dependent: :destroy
  validates_presence_of :full_name
  validates_uniqueness_of :full_name

  scope :publicated, -> { where(publicated: true)}

  def self.all_data
    Rails.cache.fetch("all_authors", expires_in: EXPIRES_IN) do
      Author.publicated.limit(DEFAULT_LIMIT_RECORD).select(:id, :full_name)
    end
  end
end
