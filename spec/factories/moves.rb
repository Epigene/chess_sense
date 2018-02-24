FactoryBot.define do
  factory :move do
    
  end
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
