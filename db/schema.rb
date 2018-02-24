# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_01_27_115903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "chess_games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.date "played_on", null: false
    t.text "white", default: "", null: false
    t.text "black", default: "", null: false
    t.text "winner", default: "", null: false
    t.text "pgn", default: "", null: false
    t.jsonb "tags", default: {}, null: false
    t.index ["black"], name: "index_chess_games_on_black"
    t.index ["created_at"], name: "index_chess_games_on_created_at"
    t.index ["played_on"], name: "index_chess_games_on_played_on"
    t.index ["tags"], name: "index_chess_games_on_tags", using: :gin
    t.index ["user_id"], name: "index_chess_games_on_user_id"
    t.index ["white"], name: "index_chess_games_on_white"
    t.index ["winner"], name: "index_chess_games_on_winner"
  end

  create_table "game_position_transitions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chess_game_id", null: false
    t.integer "position_transition_id", null: false
    t.integer "order", default: 1, null: false
    t.index ["chess_game_id", "position_transition_id", "order"], name: "gpt_uniqueness_index", unique: true
    t.index ["chess_game_id"], name: "index_game_position_transitions_on_chess_game_id"
    t.index ["created_at"], name: "index_game_position_transitions_on_created_at"
    t.index ["order"], name: "index_game_position_transitions_on_order"
    t.index ["position_transition_id"], name: "index_game_position_transitions_on_position_transition_id"
  end

  create_table "moves", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player", default: 0, null: false
    t.text "san", default: "", null: false
    t.text "lran", default: "", null: false
    t.text "from_square", default: "", null: false
    t.text "to_square", default: "", null: false
    t.integer "piece", default: 0, null: false
    t.integer "move_type", default: 0, null: false
    t.integer "captured_piece"
    t.integer "promotion"
    t.index ["captured_piece"], name: "index_moves_on_captured_piece"
    t.index ["created_at"], name: "index_moves_on_created_at"
    t.index ["from_square"], name: "index_moves_on_from_square"
    t.index ["lran", "player"], name: "moves_uniqueness_index", unique: true
    t.index ["lran"], name: "index_moves_on_lran"
    t.index ["move_type"], name: "index_moves_on_move_type"
    t.index ["piece"], name: "index_moves_on_piece"
    t.index ["player"], name: "index_moves_on_player"
    t.index ["promotion"], name: "index_moves_on_promotion"
    t.index ["san"], name: "index_moves_on_san"
    t.index ["to_square"], name: "index_moves_on_to_square"
  end

  create_table "position_transitions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "start_position_id", null: false
    t.integer "move_id", null: false
    t.integer "end_position_id", null: false
    t.index ["created_at"], name: "index_position_transitions_on_created_at"
    t.index ["end_position_id"], name: "index_position_transitions_on_end_position_id"
    t.index ["move_id"], name: "index_position_transitions_on_move_id"
    t.index ["start_position_id", "move_id", "end_position_id"], name: "pt_uniqueness_index", unique: true
    t.index ["start_position_id"], name: "index_position_transitions_on_start_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "fen", null: false
    t.jsonb "features", default: {}, null: false
    t.index ["created_at"], name: "index_positions_on_created_at"
    t.index ["features"], name: "index_positions_on_features", using: :gin
    t.index ["fen"], name: "index_positions_on_fen", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "email", null: false
    t.text "password_digest", null: false
    t.text "name", null: false
    t.jsonb "data", default: {}, null: false
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
  end

end
