class User::SenseController < ApplicationController
  include NeedsAuthenticatedUser

  # GET user_sense_path | user_sense
  def show
    render template: "user/sense/show"
  end
end
