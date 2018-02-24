class Position < ApplicationRecord
  has_many :start_position_transitions,
    class_name: "PositionTransition",
    foreign_key: "start_position_id",
    inverse_of: "start_position",
    dependent: :destroy

  has_many :position_transition_ends,
    class_name: "PositionTransition",
    foreign_key: "end_position_id",
    inverse_of: "end_position",
    dependent: :destroy

  validates :fen, :features, presence: true

end

# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fen        :text             not null
#  features   :jsonb            not null
#
# Indexes
#
#  index_positions_on_created_at  (created_at)
#  index_positions_on_features    (features)
#  index_positions_on_fen         (fen) UNIQUE
#
