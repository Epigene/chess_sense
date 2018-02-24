class CreatePositionTransitions < ActiveRecord::Migration[5.2]
  def change
    create_table :position_transitions do |t|
      t.timestamps

      t.integer :start_position_id, null: false
      t.integer :move_id, null: false
      t.integer :end_position_id, null: false
    end

    # uniqueness index
    add_index(
      :position_transitions,
      [:start_position_id, :move_id, :end_position_id],
      unique: true,
      name: "pt_uniqueness_index"
    )

    add_index(:position_transitions, :created_at)
    add_index(:position_transitions, :start_position_id)
    add_index(:position_transitions, :move_id)
    add_index(:position_transitions, :end_position_id)
  end
end
