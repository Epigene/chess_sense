class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.timestamps

      t.integer :player, null: false, default: 0 # white
      t.text :san, null: false, default: ""
      t.text :lran, null: false, default: ""
      t.text :from_square, null: false, default: ""
      t.text :to_square, null: false, default: ""
      t.integer :piece, null: false, default: 0
      t.integer :move_type, null: false, default: 0
      t.integer :captured_piece
      t.integer :promotion
    end

    add_index(:moves, :created_at)
    add_index(:moves, :player)
    add_index(:moves, :san)
    add_index(:moves, :lran)
    add_index(:moves, :from_square)
    add_index(:moves, :to_square)
    add_index(:moves, :piece)
    add_index(:moves, :move_type)
    add_index(:moves, :captured_piece)
    add_index(:moves, :promotion)
  end
end
