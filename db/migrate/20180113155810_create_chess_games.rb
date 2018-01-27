class CreateChessGames < ActiveRecord::Migration[5.2]
  def change
    create_table :chess_games do |t|
      t.timestamps

      t.integer :user_id, null: false
      t.date :played_on, null: false
      t.text :white, null: false, default: ""
      t.text :black, null: false, default: ""
      t.text :winner, null: false, default: ""
      t.text :pgn, null: false, default: ""
      t.jsonb :tags, null: false, default: {}
    end

    add_index(:chess_games, :created_at)
    add_index(:chess_games, :user_id)
    add_index(:chess_games, :played_on)
    add_index(:chess_games, :white)
    add_index(:chess_games, :black)
    add_index(:chess_games, :winner)
    add_index(:chess_games, :tags, using: :gin)
  end
end
