class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user


  def dashboard
  end

  def profile
  end

  def message
  end

  def edit
  end

  def update
  end

  protected

  def user
    @user ||= User.find_by_email(current_user.email) if current_user.present?
  end
end
