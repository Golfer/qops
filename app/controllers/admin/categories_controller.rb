module Admin
  class CategoriesController < Admin::BaseAdminController
    before_action :current_category, only: %i(update edit quotations destroy)
    before_action :categories, only: %i(index new create update edit)

    def index
    end

    def show
      respond_to :js
    end

    def new
      @category = Category.new
      @category.parent_id = params[:parent_id] if params[:parent_id]
    end

    def create
      @category = Category.new(category_params)
      respond_with({}) do |format|
        if @category.save
          format.html do
            flash[:notice] = 'Category was created.'
            redirect_to admin_categories_path
          end
        else
          format.html { render :new }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      respond_with({}) do |format|
        if @category.update(category_params)
          format.html do
            flash[:notice] = 'Category was successfully updated!'
            redirect_to admin_categories_path
          end
        else
          format.html { render :edit }
        end
      end
    end

    def published
      respond_to :js
    end

    def destroy
      @category.destroy
      respond_with({}) do |format|
        format.html do
          flash[:notice] = 'Category was destroyed!'
          redirect_to admin_categories_path
        end
      end
    end

    def quotations
      @quotations = @category.quotations
                        .paginate page: params[:page],
                                  per_page: Admin::BaseAdminController::PER_PAGE
    end

    private

    def category_params
      params.require(:category).permit(:id, :name, :parent_id)
    end

    def current_category
      @category = Category.find(params[:parent_id] ? params[:parent_id] : params[:id])
    end

    def categories
      @categories = Category.arrange_as_array order: 'name'
    end
  end
end
