class ChessGame < ApplicationRecord

  # Set up GIN indexing, at least on :moveset field

  # See:
  # 1) https://niallburkley.com/blog/index-columns-for-like-in-postgres/
  # 2) https://stackoverflow.com/questions/1566717/postgresql-like-query-performance-variations
end
