class ChessGameUploadHandler
  # This service takes in hashified params
  # Looks to parse given PGN(s) and make ChessGame records
  # Returns the number of successfuly uploaded games

  include ActiveModel::Model

  attr_accessor :pgn_lines

  validate :pgn_lines_length

  def call
    # TODO, parse the pgn_lines string
    # It can contain pairs of [optional_header, game_moves]
    # Egd::Builder.new(File.read("path/to/chess.pgn")).to_h

    {ok: 2, bad: 0, errors: []}
  end

  private
    def pgn_lines_length
      if pgn_lines.size > 20000
        errors.add(:base, "PGN upload too large, keep within 20k symbols")
      end
    end

end
