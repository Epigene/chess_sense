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
      redirect_to user_profile_path
    else
      show
    end
  end

  private

    def user_params
      params.require(:user).permit!
    end
end
