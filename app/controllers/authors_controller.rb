class AuthorsController < ApplicationController
  before_action :all_authors, only: %i(index)

  def show
  end

  private
  def all_authors
    @authors ||= Author.all_data
  end
end
