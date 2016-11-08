module Api
  module V1
    class QuotationsController < Api::V1::BaseController
      def create
        quotations =
            if params[:quotations].is_a?(String)
              JSON.parse(params[:quotations])
            else
              params[:quotations]
            end
        quotations.map do |quotation|
          exist_quotation = Quotation.find_by_text(quotation['text'])
          exist_quotation = Quotation.create quotation if exist_quotation.nil?
          exist_quotation
        end
      end


      private

      def quotation_params
        params.permit(:id, :text, :author_id, :source, :publicated, :publicated_date)
      end
    end
  end
end
