class ChessGame < ApplicationRecord
  belongs_to :user
  has_many :game_position_transitions, dependent: :destroy
  has_many :position_transitions, through: :game_position_transitions

  validates :user_id, :played_on, presence: true
  validates :white, :black, :pgn, presence: true

  scope :with_queen_trade, -> { TODO }

  scope :with_a_capture, ->(options) {
    TODO
  }

  scope :with_first_capture, ->(options) {
    with_a_capture.TODO
  }

  scope :where_a_queen_trade_initiated_by, ->(player_identifier) {
    with_queen_trade.with_first_capture(of: "Q", by: player_identifier)
  }
end

# == Schema Information
#
# Table name: chess_games
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  played_on  :date             not null
#  white      :text             default(""), not null
#  black      :text             default(""), not null
#  winner     :text             default(""), not null
#  pgn        :text             default(""), not null
#  tags       :jsonb            not null
#
# Indexes
#
#  index_chess_games_on_black       (black)
#  index_chess_games_on_created_at  (created_at)
#  index_chess_games_on_played_on   (played_on)
#  index_chess_games_on_tags        (tags)
#  index_chess_games_on_user_id     (user_id)
#  index_chess_games_on_white       (white)
#  index_chess_games_on_winner      (winner)
#
