class User::ChessGamesController < ApplicationController
  include NeedsAuthenticatedUser

  # GET user_chess_games_path | /user/chess_games
  def index
    render template: "user/chess_games/index"
  end

  # GET new_user_chess_game | /user/chess_games/new
  def new
    render template: "user/chess_games/new"
  end

  # POST /user/chess_games_path | /user/chess_games
  def create
    uploader = ChessGameUploadHandler.new(game_upload_params)

    if uploader.valid?
      uploader.call
      redirect_to user_chess_games_path, flash: {
        notice: "Game upload successful"
      }
    else
      flash.now[:data] = game_upload_params
      flash.now[:alert] = (
        ["Upload unsuccessful"] + uploader.errors.full_messages
      ).join("\n")

      new
    end
  end

  # GET user_chess_game_path | /user/chess_games/:id
  def show
    render template: "user/chess_games/show"
  end

  private
    def game_upload_params
      params.require(:chess_game).permit(:pgn_lines)
    end
end
