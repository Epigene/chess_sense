class User < ApplicationRecord
  has_secure_password

  jsonb_accessor :data,
    title: [:string, default: "Untitled"],
    previous_titles: [:string, array: true, default: []]

  has_many :chess_games, dependent: :destroy
  has_many :game_position_transitions, through: :chess_games
  has_many :position_transitions, through: :game_position_transitions

  validates :password, format: { with: /\A\S{8,128}\z/, allow_nil: true, message: :weak_password }

end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :text             not null
#  password_digest :text             not null
#  name            :text             not null
#  data            :jsonb            not null
#
# Indexes
#
#  index_users_on_created_at  (created_at)
#  index_users_on_email       (email)
#  index_users_on_name        (name)
#
