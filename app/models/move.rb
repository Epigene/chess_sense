class Move < ApplicationRecord
  enum player: {white: 0, black: 1}

  enum piece: CHESS_PIECES
  enum captured_piece: CHESS_PIECES, _prefix: "captured"
  enum promotion: CHESS_PIECES, _prefix: "promoted_to"

  enum move_type: {
    move: 0, capture: 1, ep_capture: 2, promotion_capture: 3, short_castle: 4,
    long_castle: 5, promotion: 6
  }

  has_many :position_transitions

  has_many :game_position_transitions,
    through: :position_transitions

  validates :player, :san, :lran, :from_square, :to_square, :piece, :move_type,
    presence: true

end

# == Schema Information
#
# Table name: moves
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  player         :integer          default("white"), not null
#  san            :text             default(""), not null
#  lran           :text             default(""), not null
#  from_square    :text             default(""), not null
#  to_square      :text             default(""), not null
#  piece          :integer          default("pawn"), not null
#  move_type      :integer          default("move"), not null
#  captured_piece :integer
#  promotion      :integer
#
# Indexes
#
#  index_moves_on_captured_piece  (captured_piece)
#  index_moves_on_created_at      (created_at)
#  index_moves_on_from_square     (from_square)
#  index_moves_on_lran            (lran)
#  index_moves_on_move_type       (move_type)
#  index_moves_on_piece           (piece)
#  index_moves_on_player          (player)
#  index_moves_on_promotion       (promotion)
#  index_moves_on_san             (san)
#  index_moves_on_to_square       (to_square)
#  moves_uniqueness_index         (lran,player) UNIQUE
#
