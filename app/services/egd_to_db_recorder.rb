class EgdToDbRecorder
  # This service takes in a EGD game hash
  # and makes relevant DB records

  attr_reader :pgn, :user_id

  def initialize(pgn, user_id)
    @pgn = pgn
    @user_id = user_id
  end

  def call
    return @result if defined?(@result)

    ActiveRecord::Base.transaction do
      create_a_game
      make_game_transitions
    end

    @result = true
  end

  private
    def egd
      @egd ||= Egd::Builder.new(pgn).to_h
    end

    def create_a_game
      return @game if defined?(@game)

      white = egd["game_tags"]["White"].presence || "N/A"
      black = egd["game_tags"]["Black"].presence || "N/A"

      winner =
        if egd["game_tags"]["Result"] == "1-0"
          white
        elsif egd["game_tags"]["Result"] == "0-1"
          black
        elsif egd["game_tags"]["Result"] == "1/2-1/2"
          "\ndraw"
        else
          "-"
        end

      @game = ChessGame.create!(
        user_id: user_id,
        played_on: (egd["game_tags"]["Date"].presence || Date.current).to_date,
        white: white,
        black: black,
        winner: winner,
        pgn: pgn,
        tags: egd["game_tags"].presence || {}
      )
    end

    def make_game_transitions
      egd["moves"].each.with_index(1) do |(k, position_transition_data), i|
        position_transition = ensure_position_transition(
          position_transition_data
        )

        GamePositionTransition.create!(
          chess_game_id: create_a_game.id,
          position_transition_id: position_transition.id,
          order: i
        )
      end
    end

    def ensure_position_transition(ptd)
      start_position = nil
      Retryable.retryable(tries: 2, sleep: 1) do
        start_position =
          ActiveRecord::Base.transaction do
            position = nil
            Retryable.retryable(tries: 2, sleep: 1) do
              position = Position.where(fen: ptd["start_position"]["fen"]).first_or_create!
            end

            position.update!(
              features: position.features.merge(
                ptd["start_position"]["features"]
              )
            )

            position
          end
      end

      move = nil
      Retryable.retryable(tries: 2, sleep: 1) do
        move = ActiveRecord::Base.transaction do
          m = nil
          Retryable.retryable(tries: 2, sleep: 1) do
            m = Move.where(
              player: (ptd["move"]["player"] == "w" ? "white" : "black"),
              lran: ptd["move"]["lran"]
            ).first_or_initialize

            m.update!(
              ptd["move"].except("player", "lran").merge(
                "piece" => CHESS_PIECE_MAPPING[ptd["move"]["piece"]],
                "captured_piece" => CHESS_PIECE_MAPPING[ptd["move"]["captured_piece"]],
                "promotion" => CHESS_PIECE_MAPPING[ptd["move"]["promotion"]]
              )
            ) if m.new_record?
          end

          m
        end
      end

      end_position = nil
      Retryable.retryable(tries: 2, sleep: 1) do
        end_position = ActiveRecord::Base.transaction do
          position = nil
          Retryable.retryable(tries: 2, sleep: 1) do
            position = Position.where(fen: ptd["end_position"]["fen"]).first_or_create!
          end

          position.update!(
            features: position.features.merge(
              ptd["end_position"]["features"]
            )
          )

          position
        end
      end

      position_transition = nil
      Retryable.retryable(tries: 2, sleep: 1) do
        position_transition = PositionTransition.where(
          start_position_id: start_position.id,
          move_id: move.id,
          end_position_id: end_position.id
        ).first_or_create!
      end

      position_transition
    end
end
