class Category < ApplicationRecord
  include TreeCategories

  has_many :categories_quotations
  has_and_belongs_to_many :quotations, through: :categories_quotations


  validates :name, presence: true
  validates :name, uniqueness: true

  scope :publicated, -> { where(published: true)}

  def self.all_data
    Rails.cache.fetch("all_categories", expires_in: EXPIRES_IN) do
      Category.all
    end
  end
end
