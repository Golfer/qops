class CategoriesQuotation < ApplicationRecord
  belongs_to :category
  belongs_to :quotation
end
