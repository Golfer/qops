module Admin
  class AuthorsController < Admin::BaseAdminController
    before_action :current_author, only: %i(update edit update destroy)

    def index
      @authors ||= Author.paginate page: params[:page],
                                   per_page: Admin::BaseAdminController::PER_PAGE
    end

    def show
      @author ||= Author.joins(:quotations).find(params[:id])
      @quotations ||= @author.quotations
                          .order(:publicated)
                          .paginate page: params[:page],
                                    per_page: Admin::BaseAdminController::PER_PAGE
    end

    def new
      @author = Author.new
    end

    def create
      @author = Author.new(author_params)
      respond_with({}) do |format|
        if @author.save
          format.html { redirect_to admin_authors_path, notice: 'Author was created.' }
        else
          format.html { render :new }
          format.json { render json: @author.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      respond_with({}) do |format|
        if @author.update(author_params)
          format.html do
            flash[:notice] = 'Author was successfully updated!'
            redirect_to admin_authors_path
          end
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @author.destroy
      respond_to :js
    end

    private

    def author_params
      params.require(:author).permit :id, :pseudonym, :full_name, :publicated,
                                     :description, :burn_date, :die_date
    end

    def current_author
      @author ||= Author.find(params[:id])
    end
  end
end
