module Admin
  class BaseAdminController < ApplicationController
    layout 'administaration'

    before_action :authenticate_user!
    before_action :check_permission!, if: :devise_controller?
    before_action :tree_categories

    respond_to :html, :js

    PER_PAGE = 10

    rescue_from CanCan::AccessDenied do |excpt|
      Rails.logger.debug "Access denied on #{excpt.action} #{excpt.subject.inspect}"
      flash[:error] = excpt.message
      redirect_to root_path
    end

    def check_permission!
      unless current_user.admin? || current_user.moderator?
        flash[:error] = 'Access denied! You do not have permmission for this page'
        redirect_to admin_root_path
      end
    end

    private

    def tree_categories
      @tree_categories = Category.roots.publicated
    end
  end
end
