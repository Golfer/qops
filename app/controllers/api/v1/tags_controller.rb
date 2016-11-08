module Api
  module V1
    class TagsController < Api::V1::BaseController
      def create
        super
      end

      def update
        super
      end

      def edit
        super
      end

      def destroy
        super
      end

      private

      def tag_params
        params.require(:tag).permit(:id, :name)
      end
    end
  end
end
