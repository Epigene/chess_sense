class User::ProfileController < ApplicationController
  include NeedsAuthenticatedUser

  # GET user_profile_path | /user/profile
  def show
    render template: "user/profile/show"
  end

  # PATCH user_profile_path | /user/profile
  def update
    current_user.assign_attributes(user_params)

    if current_user.save
      redirect_to user_profile_path, flash: {info: "Update successful"}
    else
      flash.now[:danger] = "There's errors!"
      show
    end
  end

  private

    def user_params
      return @user_params if defined?(@user_params)

      @user_params = params.require(:user).permit(
        :password, :password_confirmation, :name, :chess_aliases#, chess_aliases: []
      ).to_h

      split_aliases = @user_params[:chess_aliases].gsub("\r", "").split("\n").uniq.sort

      @user_params.merge!(chess_aliases: split_aliases)
    end
end
