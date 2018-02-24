module ControllerHelpers
  def allow_render
    allow(controller).to receive(:render)
  end

  def log_in_user(user=nil)
    logged_in_user = user.presence || create(:user)
    session[:user_id] = logged_in_user.id

    logged_in_user
  end
end
