class User::ChessGamesController < ApplicationController
  include NeedsAuthenticatedUser

  # GET user_chess_games_path | /user/chess_games
  def index
    render template: "user/chess_games/index"
  end

  # GET user_chess_game_path | /user/chess_games/:id
  def show
    render template: "user/chess_games/show"
  end
end
