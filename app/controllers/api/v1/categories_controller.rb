module Api
  module V1
    class CategoriesController < Api::V1::BaseController

      private

      def category_params
        params.require(:category).permit(:id, :name, :ancestry, :published)
      end

    end
  end
end
