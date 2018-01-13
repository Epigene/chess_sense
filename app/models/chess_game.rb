class ChessGame < ApplicationRecord

  # Set up GIN indexing, at least on :moveset field

  # See:
  # 1) https://niallburkley.com/blog/index-columns-for-like-in-postgres/
  # 2) https://stackoverflow.com/questions/1566717/postgresql-like-query-performance-variations

  scope :with_queen_trade, -> { TODO }

  scope :with_a_capture, ->(options) {
    TODO
  }

  scope :with_first_capture, ->(options) {
    with_a_capture.TODO
  }

  scope :where_a_queen_trade_initiated_by, ->(player_identifier) {
    with_queen_trade.with_first_capture(of: "Q", by: player_identifier)
  }
end
