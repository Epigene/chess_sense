class User::SenseController < ApplicationController
  include NeedsAuthenticatedUser

  before_action :ensure_selected_tell_me

  # GET user_sense_path | user_sense
  def show
    sense_data = Sense.new(sense_params).call

    render template: "user/sense/show", locals: {sense_data: sense_data}
  end

  private
    DEFAULT_TELL_ME = "size".freeze

    def ensure_selected_tell_me
      if params[:tell_me].blank?
        redirect_to user_sense_path(tell_me: DEFAULT_TELL_ME)
      end
    end

    def sense_params
      return @sense_params if defined?(@sense_params)

      all_params = params.permit!.to_h.deep_symbolize_keys
      present_params = all_params.reject {|k, v| v.blank? }

      @sense_params = present_params.slice(:tell_me, :where, :look_at).merge(
        user_id: current_user.id
      )
    end
end
