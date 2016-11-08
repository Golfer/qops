class TagsController < ApplicationController

  before_action :all_tags, only: %i(index)

  private

  def all_tags
    @tags ||= Tag.all_data
  end
end
