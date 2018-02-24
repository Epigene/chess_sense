class SessionController < ApplicationController

  # GET root_path | /
  def new
    if session[:user_id].present?
      redirect_to user_sense_path
    else
      render template: "session/new", locals: {login: login}
    end
  end

  # POST login_path | /login
  def create
    @login = Login.new(login_params)
    user = @login.authenticated_user

    if user.present?
      session[:user_id] = user.id
      redirect_to user_sense_path
    else
      new
    end
  end

  # DELETE logout_path | /logout
  def destroy
    session.delete(:user_id)

    redirect_to root_path
  end

  private
    def login
      @login ||= Login.new
    end

    def login_params
      params.require(:login).permit(:email, :password)
    end
end
