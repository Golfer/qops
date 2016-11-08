module Api
  module V1
    class BaseController < Api::BaseController
      protect_from_forgery with: :null_session,
                           if: Proc.new { |c| c.request.format =~ %r{application/json} }
      class_methods
      respond_to :json

      PER_PAGE = 10000

      def index
        respond_with controller_name.classify.constantize.limit Api::V1::BaseController::PER_PAGE
      end

      def show
        respond_with controller_name.classify.constantize.limit Api::V1::BaseController::PER_PAGE
      end

      def create
        class_params = send("#{controller_name.classify.downcase}_params".to_sym)
        obj = controller_name.classify.constantize.create(class_params)
        # respond_with @obj.to_json
        # serialize(obj) TODO Need Add serializer !!!
        respond_with obj.to_json
      rescue => e
        fail "Create #{controller_name.classify.constantize} Error! #{e.message}"
      end

      def edit
      end

      def update
      end

      def destroy
      end

      def multy_uploader
        author
        quotations
        data_response =
            {
                author: @author,
                quotation: @quotations
            }
        respond_with data_response, location: root_path
      end

      protected

      def author
        params_author = params[:author].is_a?(String) ? JSON.parse(params[:author]) : params[:author]
        params_author = params_author.deep_symbolize_keys
        @author = Author.find_by_full_name(params_author['full_name'])
        @author = Author.create(params_author) if @author.nil?
        @author
      rescue => e
        flash.now[:error] = "Author had some error! #{e.message}"
      end

      def quotations
        @tags = []
        @categories = []
        if params[:quotations].present?
          Quotation.transaction do
            params_quotations = params[:quotations].is_a?(String) ? JSON.parse(params[:quotations]) : params[:quotations]
            @quotations = params_quotations.each do |quotation|
              q_params = quotation.deep_symbolize_keys
              current_quotation = Quotation.find_by_text(q_params[:text])
              current_quotation = Quotation.create(author_id: @author.id, text: q_params[:text], source: q_params[:source], publicated: true) if current_quotation.nil?
              current_quotation
              tags(q_params[:tags], current_quotation) if q_params[:tags]
              categories(q_params[:categories], current_quotation) if q_params[:categories]
            end
          end
        end

        @quotations
      end

      def tags(tags, quotation)
        @tags = tags.map do |tag|
          cur_tag = Tag.find_by_name(tag)
          cur_tag = Tag.create(name: tag) if cur_tag.nil?
          quotation.tags << cur_tag
        end if tags.present?
        @tags
      rescue => e
        flash.now[:error] = "Tag Error! #{e.message}"
      end

      def categories(categories, quotation)
        categories = ['none_category'] if categories.empty?
        categories.map do |category|
          cur_cat = Category.find_by_name(category)
          cur_cat = Category.create(name: category) if cur_cat.nil?
          quotation.categories << cur_cat
        end
      rescue => e
        flash.now[:error] = "Category Error! #{e.message}"
      end

      #Need think about authentification for API REQUESTER

      # def token_authenticate
      #   sign_out
      #   if !(authenticate_user_from_header_token || authenticate_user_by_params_token)
      #     respond_with({error: 'Invalid API Token'}, {status: 401, location: root_url})
      #   end
      # end
      #
      # def authenticate_user_from_header_token
      #   return true if current_user
      #   authenticate_with_http_token do |token, options|
      #     user = User.no_active_invitation
      #                .with_token(token,
      #                            options[:salt].present? ? :mobile : :api,
      #                            options[:salt]
      #                ).first
      #     sign_in(user, {store: false}) if user
      #   end
      # end
      #
      # def authenticate_user_by_params_token
      #   return true if current_user
      #   return false unless params[:token]
      #   user = User.no_active_invitation
      #              .with_token(params[:token],
      #                          params[:salt].present? ? :mobile : :api,
      #                          params[:salt]
      #              ).first
      #   sign_in(user, {store: false}) if user
      # end
    end
  end
end
