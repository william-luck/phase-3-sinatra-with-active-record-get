class ApplicationController < Sinatra::Base

  # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'

  get '/games' do
    # get all the games from the database 
    games = Game.all.order(:title).limit(10)
    # return a JSON response with an array of all the game data
    games.to_json
  end

  # use the :id route here to create a dynamic route, using the params hash.
  # If for exmaple make a get request to /games/10, the params hash would be { 'id' => '10' }
  get '/games/:id' do 
    # look up in the database using the ID, remember find method uses the ID 
    # The params[:id] is just a way of getting 10 from the params hash.
    game = Game.find(params[:id])
    # includes all the reviews associated with the game in the JSON response
    game.to_json(include: {reviews: { include: :user } })
  end

end
