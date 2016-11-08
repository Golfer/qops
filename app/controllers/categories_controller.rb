class CategoriesController < ApplicationController
  before_action :all_categories, only: %i(index)

  private
  def all_categories
    @categories = Category.all_data
  end
end
