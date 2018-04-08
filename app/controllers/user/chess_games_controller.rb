class User::ChessGamesController < ApplicationController
  include NeedsAuthenticatedUser

  GAME_PAGE_SIZE = 15.freeze

  before_action :validate_access_to_game, only: :show

  # GET user_chess_games_path | /user/chess_games
  def index
    render template: "user/chess_games/index", locals: {games: games}
  end

  # GET new_user_chess_game | /user/chess_games/new
  def new
    render template: "user/chess_games/new", locals: {uploader: uploader}
  end

  # POST user_chess_games_path | /user/chess_games
  def create
    uploader = ChessGameUploadHandler.new(
      game_upload_params.merge(user_id: current_user.id)
    )

    if uploader.valid?
      upload_outcome = uploader.call

      flash_content =
        if upload_outcome[:bad].to_i == 0
          {success: "#{upload_outcome[:ok]} game(s) uploaded!"}
        else
          {
            danger: (
              "#{upload_outcome[:ok]} game(s) uploaded, "\
              "#{upload_outcome[:bad]} game(s) could not be uploaded.\n"\
              "The errors were:\n #{upload_outcome[:errors]}"
            )
          }
        end

      redirect_to user_chess_games_path, flash: flash_content
    else
      flash.now[:danger] = (
        ["Upload unsuccessful"] + uploader.errors.full_messages
      ).join("\n")

      @uploader = uploader

      new
    end
  end

  # GET user_chess_game_path | /user/chess_games/:id
  def show
    render template: "user/chess_games/show", locals: {game: game}
  end

  private
    def uploader
      @uploader ||= ChessGameUploadHandler.new
    end

    def game_upload_params
      params.require(:chess_game_upload_handler).permit(:pgn_lines)
    end

    def games
      @games ||= current_user.chess_games.order(id: :desc).page(params[:page]).per(GAME_PAGE_SIZE)
    end

    def game
      @game ||= ChessGame.find(params[:id])
    end

    def validate_access_to_game
      if game.user != current_user
        flash[:danger] = "That's someone else's game"
        redirect_back(fallback_location: user_chess_games_path)
      end
    end
end
