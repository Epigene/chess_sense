class Sense
  # This service expects a hash of scopes,
  # Usually submitted from User::Sense show view
  # returns sense data

  include ActiveModel::Model

  PLAYED_BY_SELF = "\nme".freeze

  attr_accessor :user_id, :tell_me, :where, :look_at

  def initialize(user_id:, tell_me:, where: {}, look_at: {})
    @user_id = user_id
    @tell_me = tell_me
    @where = where
    @look_at = look_at
  end

  def call
    # user.chess_games.
  end

  private
    def user
      return @user if defined?(@user)

      @user = User.find_by(id: user_id) || raise(
        "No User##{user_id}"
      )
    end

    def game_scope
      #return @?? if defined?(@??)

      #user.chess_games
    end

    # allowed :tell_me scopes

    def size
      # - >[ ] "size" | How many games are there? # simple count
    end

    def results
      # - >[ ] "results", "Epigene" | What are (player)'s win-draw-loss results?
    end

    def openings
      # - >[ ] "openings"| What openings are played?
    end

    def queen_captures
      # - >[ ] "queen_trades"| What Queen captures and losses occur from (player)'s perspective?
    end

    def positions
      # - >[ ] "positions", "10" | What positions occur the most after the (n)th move? # n at least 10

    end

    def captures
      # - >[ ] "trades", "Epigene" | What are (player)'s piece trade outcomes? (Does (player) capture Rooks/Queen with knight, bishops, what is lost?)

    end

    # allowed :where scopes

    def played_on
      # - >[ ] "played_on", "2018-01-01", "2018-01-31" | played on (start_date) - (end_date)

    end

    def played_by
      # - >[ ] "played_by", "Epigene", "any" | played by (player) as (white, black, any)

    end

    def outcome
     #  - >[ ] "outcome", "Epigene", "drew" | (player) (won, lost, drew)

    end

    def opening
      # - >[ ] "opening", "A00" | (opening (eco code)) is played

    end

    def opening_regex
      # - >[ ] "opening_regex", "TODO" | (moveset regex) is played # Haard...

    end

    def queen_capture
      # - >[ ] "queen_capture", "Epigene", "initiate" | (player) (initiate, take_back, any) a Queen trade

    end

    def capture
      # - >[ ] "piece_capture", "Epigene", "queen", "dark_bishop" | (player) captures (piece) with (piece) # Haaard..

    end

    # allowed :look_at scopes

    def all
      # - >[ ] "all" | all games # easy default

    end

    def last
      # - >[ ] "last", "100" | latest (n) games

    end

    def last_percent
      # - >[ ] "last_percent", "33" | latest (n) percent of games

    end
end
