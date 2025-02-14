class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

  delete '/reviews/:id' do
    review = Review.find(params[:id])
    review.destroy
    review.to_json
  end

  post '/reviews' do
    new_review=Review.create(params)
    new_review.to_json
  end

  patch '/reviews/:id' do
    updated= Review.find(params[:id])
    updated.update(params)
    updated.to_json
  end

end
