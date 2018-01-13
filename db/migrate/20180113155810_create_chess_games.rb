class CreateChessGames < ActiveRecord::Migration[5.2]
  def change
    create_table :chess_games do |t|
      t.timestamps
    end
  end
end
