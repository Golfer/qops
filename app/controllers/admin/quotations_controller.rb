module Admin
  class QuotationsController < Admin::BaseAdminController
    before_action :current_quotation, only: %i(update edit show update destroy publicated)
    before_action :list_by_author
    def show
    end

    def index
      @quotations = Quotation.paginate(page: params[:page],
                                         per_page: Admin::BaseAdminController::PER_PAGE)
    end

    def update
      respond_with({}) do |format|
        if @quotation.update(quotation_params)
          format.html do
            flash[:notice] = 'Quotation was successfully updated!'
            redirect_to admin_quotations_path
          end
        else
          format.html { render :edit }
        end
      end
    end

    def new
      @quotation = Quotation.new
    end

    def create
      @quotation = Quotation.new(quotation_params)
      respond_with({}) do |format|
        if @quotation.save
          format.html do
            flash[:notice] = 'Quotation was created.'
            redirect_to admin_quotations_path
          end
        else
          format.html { render :new }
          format.json { render json: @quotation.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def destroy
      @quotation.destroy
      respond_with({}) do |format|
        format.html do
          flash[:notice] = 'Quotation was destroyed!'
          redirect_to admin_quotations_path
        end
      end
    end

    def publicated
      pub_status = @quotation.publicated ? false : true
      @quotation.update(publicated: pub_status)
      respond_to :js
    end

    def author_quotations_publicate
      @quotations.update_all(publicated: true)
      flash[:notice] = 'All quotation waere publicated'
      redirect_to admin_authors_path
    end

    def author_quotations_unpublicate
      @quotations.update_all(publicated: false)
      flash[:notice] = 'All quotation waere un publicated'
      redirect_to admin_authors_path
    end

    private

    def quotation_params
      params.require(:quotation).permit(:id, :text, :author_id)
    end

    def current_quotation
      @quotation ||= Quotation.find(params[:id])
    end

    def list_by_author
      @quotations ||= Quotation.joins(:author).where(author_id: params[:author_id])
    rescue StandardError => e
      flash[:error] = "Do not find Author. \n #{e.message}"
      redirect_to admin_authors_path
    end
  end
end
