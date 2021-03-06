FactoryBot.define do
  factory :chess_game do
    user { create(:user) }
    played_on { Date.today }
    white "Rufus"
    black "Dufus"
    pgn "1. e4 e5 *"
    setting_victor # override by specifying :result

    transient do
      result { "*" }
      # won_by { "-" }
    end

    #== traits below ==

    trait :setting_victor do
      tags {
        {"Event"=>"Spec", "Result"=>result}
      }

      winner {
        if result == "1-0"
          white
        elsif result == "0-1"
          black
        elsif result == "1/2-1/2"
          "\ndraw"
        else
          "-"
        end
      }
    end

    trait(:decided) { result { "1-0" } }

    trait :draw do
      result { "1/2-1/2" }
    end

    trait :undecided do
      result { "*" }
    end

  end
end

# == Schema Information
#
# Table name: chess_games
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  played_on  :date             not null
#  white      :text             default(""), not null
#  black      :text             default(""), not null
#  winner     :text             default(""), not null
#  pgn        :text             default(""), not null
#  tags       :jsonb            not null
#
# Indexes
#
#  index_chess_games_on_black       (black)
#  index_chess_games_on_created_at  (created_at)
#  index_chess_games_on_played_on   (played_on)
#  index_chess_games_on_tags        (tags)
#  index_chess_games_on_user_id     (user_id)
#  index_chess_games_on_white       (white)
#  index_chess_games_on_winner      (winner)
#
