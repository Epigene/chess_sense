module ChessHelpers
  def valid_pgn_upload
    <<~HEREDOC
    1. b3 a5 *
    HEREDOC
  end

  def partially_valid_pgn_upload
    <<~HEREDOC
    1. b3 a5 *

    1. b3 b2 b2 b2
    HEREDOC
  end

  def standart_pgn_upload
    <<~HEREDOC
    [Event "Live Chess"]
    [Site "Chess.com"]
    [Date "2018.01.13"]
    [Round "-"]
    [White "augustsbautra"]
    [Black "test_opponent"]
    [Result "1-0"]
    [WhiteElo "1350"]
    [BlackElo "1152"]
    [TimeControl "180"]
    [EndTime "6:25:26 PST"]
    [Termination "augustsbautra won by checkmate"]

    1. b3 e5 1-0
    HEREDOC
  end

  def two_game_pgn_upload
    <<~HEREDOC
    1. b3 a5

    1. b4 e5 0-1
    HEREDOC
  end

  def no_blank_lines_pgn_upload
    <<~HEREDOC
    1. b3 a5
    [Date "2018.01.13"]
    1. b4 e5
    2. b5 e4
    0-1
    HEREDOC
  end

  # first game is garbled
  def mixed_pgn_upload
    <<~HEREDOC
    [Date "2018.01.13"]
    [White "augustsbautra"]
    [Black "test_opponent"]
    [Result "1-0"]

    ?#

    1. b3 *

    [Event "Live Chess"]
    [Site "Chess.com"]
    [Date "2018.03.04"]
    [Round "-"]
    [White "test_opponent"]
    [Black "augustsbautra"]
    [Result "0-1"]
    [WhiteElo "1435"]
    [BlackElo "1509"]
    [TimeControl "180"]
    [EndTime "7:08:16 PST"]
    [Termination "augustsbautra won on time"]

    1. d4 1... Nf6
    HEREDOC
  end
end
