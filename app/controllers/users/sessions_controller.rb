class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  def new
    self.resource = resource_class.new(sign_in_params)
    store_location_for(resource, params[:redirect_to])
    super
  end

  def create
    #TODO Need investigate. How we can realize this
    # redirect_to %i(admin root) if  (current_user.admin? || current_user.moderator?)
    super
  end

  def destroy
    super
  end

  private

  def user_params
    accessible = [ :name, :email ]
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
