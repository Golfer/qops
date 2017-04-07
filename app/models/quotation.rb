class Quotation < ApplicationRecord
  DEFAULT_LATEST_RECORD = 100

  has_many :categories_quotations
  has_and_belongs_to_many :categories, through: :categories_quotations

  has_many :tags_quotations
  has_and_belongs_to_many :tags, through: :tags_quotations

  belongs_to :author

  validates :text, presence: true

  scope :publicated, -> { includes(:tags).where(publicated: true).order(updated_at: :desc) }


  def self.latest(limit = DEFAULT_LATEST_RECORD)
    Quotation.publicated.limit(limit).order(updated_at: :desc)
  end
end
