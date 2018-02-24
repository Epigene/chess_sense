FactoryBot.define do
  factory :position do
    
  end
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
