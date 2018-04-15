class ChessGame < ApplicationRecord
  OUTCOMES = %Q|win loss draw undecided|.freeze

  # For games that have an undecided ("*") Result tag, the :winner is "-"
  # For games that have a drawn Result ("1/2-1/2"), the winner is "\ndraw"

  belongs_to :user
  has_many :game_position_transitions, dependent: :destroy
  has_many :position_transitions, through: :game_position_transitions

  validates :user_id, :played_on, presence: true
  validates :white, :black, :pgn, presence: true

  #== Scopes below ==

  scope :played_by, ->(*p) {
    player = [p].flatten

    as_white = where(white: player).select(:id)
    as_black = where(black: player).select(:id)

    where(id: as_white).or(where(id: as_black))
  }

  scope :with_winner, ->(*w) {
    winner = [w].flatten

    subselect =
      if w.any?
        where(winner: winner).select(:id)
      else
        decided.select(:id)
      end

    where(id: subselect)
  }

  scope :without_winner, ->(*w) {
    winner = [w].flatten

    subselect =
      if w.any?
        where.not(winner: winner)
      else
        where.not(id: with_winner).select(:id)
      end

    where(id: subselect)
  }

  scope :with_loser, ->(*l) {
    loser = [l].flatten

    if l.any?
      subselect = played_by(loser).with_winner.where.not(winner: loser).select(:id)
      where(id: subselect)
    else
      # same as with_winner, i.e. determined outcome
      with_winner
    end
  }

  scope :decided, -> { where.not(winner: ["-", "\ndraw"]) }
  scope :draw, -> { where(winner: "\ndraw") }
  scope :undecided, -> { where(winner: "-") }

  scope :of_outcome, ->(o:, for_player:) {
    # TODO, allow for combined outcomes
    outcome = [o].flatten.first # first here will come off with combinations
    player = [for_player].flatten

    subselect =
      case outcome
      when "win"
        with_winner(player).select(:id)
      when "loss"
        with_loser(player).select(:id)
      when "draw"
        played_by(player).draw.select(:id)
      when "undecided"
        played_by(player).undecided.select(:id)
      end

    where(id: subselect)
  }

  # scope :with_queen_trade, -> { TODO }

  # scope :with_a_capture, ->(options) {
  #   TODO
  # }

  # scope :with_first_capture, ->(options) {
  #   with_a_capture.TODO
  # }

  # scope :where_a_queen_trade_initiated_by, ->(player_identifier) {
  #   with_queen_trade.with_first_capture(of: "Q", by: player_identifier)
  # }

  def to_row
    "#{id}. on #{played_on}, #{white} VS #{black} | #{tags["Result"]}"
  end
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
