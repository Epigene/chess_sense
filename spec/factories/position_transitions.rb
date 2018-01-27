FactoryBot.define do
  factory :position_transition do
    
  end
end

# == Schema Information
#
# Table name: position_transitions
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  start_position_id :integer          not null
#  move_id           :integer          not null
#  end_position_id   :integer          not null
#
# Indexes
#
#  index_position_transitions_on_created_at         (created_at)
#  index_position_transitions_on_end_position_id    (end_position_id)
#  index_position_transitions_on_move_id            (move_id)
#  index_position_transitions_on_start_position_id  (start_position_id)
#
