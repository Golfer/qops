module Api
  module V1
    class AuthorsController < Api::V1::BaseController


      def create
        author = Author.find_by_full_name(author_params[:full_name])
        author = Author.create(author_params) if author.nil?
        author
      rescue => e
        flash.now[:error] = "Author had some error! #{e.message}"
      end

      private

      def author_params
        params.permit(:id, :pseudonym, :full_name, :publicated, :description, :burn_date, :die_date)
      end

    end
  end
end
