class Tag < ApplicationRecord
  has_many :tags_quotations
  has_and_belongs_to_many :quotations, through: :tags_quotations

  validates :name, presence: true, length: { maximum: 128 }
  validates :name, uniqueness: true

  DEFAULT_LIMIT_RECORD = 500

  def self.all_data
    Rails.cache.fetch("all_tags", expires_in: EXPIRES_IN) do
      Tag.limit(DEFAULT_LIMIT_RECORD).select(:id, :name)
    end
  end

end
