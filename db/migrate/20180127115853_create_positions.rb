class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.timestamps

      t.text :fen, null: false
      t.jsonb :features, null: false, default: {}
    end

    add_index(:positions, :created_at)
    add_index(:positions, :fen)
    add_index(:positions, :features, using: :gin)
  end
end
