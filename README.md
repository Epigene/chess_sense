# Chess Sense
A Rails app for maintaining your chess game database and gleaning insights with powerful statistical analysis.

## Installation
1. Consult the gemfile for Ruby and bundler versions, install those.
2. Depends on PostgreSQL v10+, install it.
3. Create a `database.yml` from the `database_example.yml`
4. Bundle
5. Set up with `rails db:create db:migrate db:seed`
6. See if specs are green with `rspec`

## Deployment
Production runs two processes - Puma webserver and Sidekiq worker, so make sure to (re)boot those on deployments.  

Currently the app is hosted on Heroku @ TODO.

## What this does
>* User has a DB of games, not necessarily played by themselves  
So ChessGame Model must have a :user_id and a :w_player and :b_player field

>* ChessGame has :played_on field that gets populated from tags or if no tags default to upload date

>* User specifies the names of games which identify their games  
  TODO: How to identify repeat games? Moves can be the same, TAGS only, if applicable.   
  Default to games with the same moves being different, but if TAGs match, then its repeat and do not import

>* User can save query scopes? (Like if I upload games of my opponent and want to query those as a group)

## Queries:

  >* what are the win-draw-loss results?  

  >* what are my piece trade outcomes? (I capture Rooks/queen with knight, bishops, what do I lose?)  

  >* what positions occur the most (by move n)? 

  
```rb
[
  where(
    <player>_plays_as_<side>,
    moves [<opening or moveset regex>] are played,
    <player_or_I>_initiate queen trade, Opponent_initiates queen trade
    <player_or_I>_trade for a better piece, Opponent wins a better piece from me,
    <player_or_I>_win, <player_or_I>_lose,  It's a draw
    :played_on_dates_in_<range>
  ), 
  select(
    last_<n>_games_of_matching_games,
    last_<n>_percent_of_matching_games
  )
]
```

  

