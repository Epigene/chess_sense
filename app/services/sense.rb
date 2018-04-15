class Sense
  # This service expects a hash of scopes,
  # Usually submitted from User::Sense show view
  # returns sense data

  include ActiveModel::Model

  PLAYED_BY_SELF = "\nme".freeze

  ALLOWED_TELL_ME_METHODS = %w|
    size results openings queen_captures positions captures
  |.freeze

  ALLOWED_WHERE_SCOPES = %w|
      played_on played_by outcome opening opening_rege queen_capture capture
  |.freeze

  ALLOWED_LOOK_AT_SCOPES = %w|all last last_percent|

  attr_accessor :user_id, :tell_me, :where, :look_at

  def initialize(user_id:, tell_me: ["size"], where: {}, look_at: ["all"])
    @user_id = user_id.freeze
    @tell_me = tell_me.freeze
    @where = where.freeze
    @look_at = look_at.freeze
  end

  def call
    @call ||=
      if ALLOWED_TELL_ME_METHODS.include?(tell_me.first.to_s)
        send(tell_me_method, *tell_me_possible_args)
      else
        raise(
          "Unsupported :tell_me method requested! The arg was '#{tell_me}'"
        )
      end
  end

  private
    def user
      return @user if defined?(@user)

      @user = User.find_by(id: user_id) || raise(
        "No User##{user_id}"
      )
    end

    def game_scope
      return @game_scope if defined?(@game_scope)

      games = ALLOWED_WHERE_SCOPES.each_with_object(user.chess_games) do |scope, mem|
        if where.has_key?(scope)
          possible_args = where[scope].presence || []

          mem.send(scope, *possible_args)
        end
      end

      @game_scope =
        if ALLOWED_LOOK_AT_SCOPES.include?(look_at.first)
          scope = method_from_array(look_at.dup)
          possible_args = possible_args_from_array(look_at.dup)

          games.send(scope, *possible_args)
        else
          games
        end
    end

    def tell_me_method
      @tell_me_method ||= method_from_array(tell_me.dup)
    end

    def tell_me_possible_args
      @tell_me_possible_args ||= possible_args_from_array(tell_me.dup)
    end

    # allowed :tell_me scopes

    def size
      {size: game_scope.distinct.size}
    end

    def results(*passed_nicks)
      player = player_nicknames(passed_nicks)

      {
        win: game_scope.of_outcome(o: "win", for_player: player).distinct.size,
        loss: game_scope.of_outcome(o: "loss", for_player: player).distinct.size,
        draw: game_scope.of_outcome(o: "draw", for_player: player).distinct.size,
        undecided: game_scope.of_outcome(o: "undecided", for_player: player).distinct.size
      }
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

    # real private
    def method_from_array(array)
      array.shift
    end

    def possible_args_from_array(array)
      array.shift # throw away method

      array # returned left possible args
    end

    def player_nicknames(player)
      if player.first == "\nme"
        # use nicks from config
        user.chess_aliases
      else
        # use unchanged
        player
      end
    end
end
