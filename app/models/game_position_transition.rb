class GamePositionTransition < ApplicationRecord
  belongs_to :chess_game
  belongs_to :user, through: :chess_game
  belongs_to :position_transition

  validates :chess_game_id, :position_transition_id, :order, presence: true
end

# == Schema Information
#
# Table name: game_position_transitions
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  chess_game_id          :integer          not null
#  position_transition_id :integer          not null
#  order                  :integer          default(1), not null
#
# Indexes
#
#  index_game_position_transitions_on_chess_game_id           (chess_game_id)
#  index_game_position_transitions_on_created_at              (created_at)
#  index_game_position_transitions_on_order                   (order)
#  index_game_position_transitions_on_position_transition_id  (position_transition_id)
#
