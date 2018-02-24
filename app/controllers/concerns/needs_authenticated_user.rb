module NeedsAuthenticatedUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :verify_authenticated_user

    before_action :verify_authenticated_user
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  def verify_authenticated_user
    redirect_to root_path if current_user.blank?
  end
end
