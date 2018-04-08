# Chess Sense
WORK IN PROGRESS. A Rails app for maintaining your chess game database and gleaning insights with powerful statistical analysis.

## Installation
1. Consult `Gemfile` for Ruby and bundler versions, install those.
2. Depends on PostgreSQL v9.6+, install it.
3. Create a `database.yml` from the `database_example.yml`
4. Bundle
5. Set up with `rails db:create db:migrate db:seed`
6. See if specs are green with `rspec`

## Deployment
Production runs two processes - Puma webserver and Sidekiq worker, so make sure to (re)boot those on deployments.  

Currently the app is hosted on Heroku @ TODO.

## ChessSense querying
The query interface is modeled somewhat after SQL.  
* You have `TELL ME` statements that let you pick an insight you want answered about the given dataset.
* You have `WHERE` statements that help you select the subset of games you are interested (who played, what opening was used etc.)
* You have `LOOK AT` statements that let you narrow down the dataset to some count or percent

## Feature roadmap
`TELL ME`
- >[ ] How many games are there? # simple count  
- >[ ] What are (player)'s win-draw-loss results?  
- >[ ] What positions occur the most after the (n)th move? # n at least 10
- >[ ] What are (player)'s piece trade outcomes? (Does (player) capture Rooks/Queen with knight, bishops, what is lost?)  

`WHERE`
- >[ ] played on (start_date) - (end_date)
- >[ ] played by (player) as (white, black, any)
- >[ ] (player) (won, lost, drew)
- >[ ] (opening) is played
- >[ ] (moveset regex) is played # Haard...
- >[ ] (player) initiates a Queen trade
- >[ ] (player) trades (piece) for a (piece) # Haaard..

`LOOK AT`
- >[ ] latest (n) games
- >[ ] latest (n) percent of games

__GENERAL__
- >[ ] Users can save query scopes (like `played_by(ereatest_genemy)`)
  
## Assumptions
A sequence of moves where players each lose a piece of equal value (Bishops equaling Knights) within 3 moves is considered a "trade".

For example:
* a single move queen trade: Qxd8 Kxd8
* a recapture with a check intermezzo: Qxd8 Bxh2+ (checking the castled white king with a sac) Kh1 (white king steps out of check) Kxd8
