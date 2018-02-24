FactoryBot.define do
  factory :chess_game do
    user { create(:user) }
    played_on { Date.today }
    white "Rufus"
    black "Dufus"
    winner "-"
    pgn "1. e4 e5 *"
    tags({"Event"=>"Spec"})
  end
end
