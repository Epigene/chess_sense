class User < ApplicationRecord
  has_secure_password

  attr_accessor :password_confirmation

  jsonb_accessor :data,
    chess_aliases: [:string, array: true, default: []]

  has_many :chess_games, dependent: :destroy
  has_many :game_position_transitions, through: :chess_games
  has_many :position_transitions, through: :game_position_transitions

  validates :email, presence: true, format: {
    with: %r'\A[^@]+@[^@]+\.[^@]+\z'i, allow_nil: false
  }

  validates :password, format: {
    with: %r'\A\S{4,}\z'i, allow_nil: true
  }

  validates :password_digest, presence: true

  validates :name, presence: true, format: {
    with: %r'\A\S+(\s+\S+)*\z'i, allow_nil: false
  }

  validates :data, presence: true

  validate :password_matches_confirmation

  private
    def password_matches_confirmation
      return true if password.blank?

      password.to_s == password_confirmation.to_s
    end
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
#  index_users_on_email       (email) UNIQUE
#  index_users_on_name        (name)
#
