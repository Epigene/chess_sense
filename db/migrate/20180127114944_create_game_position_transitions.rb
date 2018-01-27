class CreateGamePositionTransitions < ActiveRecord::Migration[5.2]
  def change
    create_table :game_position_transitions do |t|
      t.timestamps

      t.integer :chess_game_id, null: false
      t.integer :position_transition_id, null: false
      t.integer :order, null: false, default: 1
    end

    add_index(:game_position_transitions, :created_at)
    add_index(:game_position_transitions, :chess_game_id)
    add_index(:game_position_transitions, :position_transition_id)
    add_index(:game_position_transitions, :order)
  end
end
