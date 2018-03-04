class ChessGameUploadHandler
  # This service takes in hashified params
  # Looks to parse given PGN(s) and make ChessGame records
  # Returns the number of successfuly uploaded games

  include ActiveModel::Model

  attr_accessor :pgn_lines, :user_id

  validate :pgn_lines_length

  def call
    upload_results = {ok: 0, bad: 0, errors: []}

    seperate_games.each do |pgn|
      begin
        EgdToDbRecorder.new(pgn, user_id).call
      rescue => e
        upload_results[:bad] += 1
        upload_results[:errors] << e.message
        next
      end

      upload_results[:ok] += 1
    end

    upload_results
  end

  private
    def pgn_lines_length
      if pgn_lines.size > 20000
        errors.add(:base, "PGN upload too large, keep within 20k symbols")
      end
    end

    def seperate_games
      return @seperate_games if defined?(@seperate_games)

      @seperate_games = []
      @latest_game = ""
      @latest_present_line = ""

      pgn_lines.each_line do |line|
        if @latest_game.blank?
          @latest_game << line
          @latest_present_line = line if line.present?
        else
          if @latest_present_line.to_s[0] == "["
            # header in memo
            if line.to_s[0] == "["
              @latest_game << line
              @latest_present_line = line
            elsif line.blank?
              @latest_game << line
            else
              @latest_game << line
              @latest_present_line = line
            end
          else
            # move in memo
            if line.to_s[0] == "["
              # new header!
              @seperate_games << @latest_game
              @latest_game = ""
              @latest_game << line
              @latest_present_line = line
            elsif line.blank?
              @seperate_games << @latest_game
              @latest_game = ""
              @latest_game << line
              @latest_present_line = ""
            else
              # another move line
              @latest_game << line
              @latest_present_line = line
            end
          end
        end
      end

      @seperate_games << @latest_game if @latest_game.present?
    end

end
