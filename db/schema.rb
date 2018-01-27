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

ActiveRecord::Schema.define(version: 2018_01_13_160911) do

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

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "email", null: false
    t.text "password_digest", null: false
    t.text "name", null: false
    t.jsonb "data", default: {}, null: false
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["name"], name: "index_users_on_name"
  end

end
