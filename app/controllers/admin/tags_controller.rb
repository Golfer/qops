module Admin
  class TagsController < Admin::BaseAdminController

    before_action :all_tags, only: %i(index)

    def show
    end

    def index
    end

    def update
    end

    def create
    end

    def delete
    end

    def published
    end

    private

    def all_tags
      @tags ||= Tag.all_data
    end
  end
end
