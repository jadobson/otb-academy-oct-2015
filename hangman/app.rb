require 'sinatra'
require_relative 'lib/game'

class HangmanController < Sinatra::Base
  enable :sessions

  configure do
    set :game, Game.new
  end

  get '/?' do
    erb :index
  end

  get '/play/?' do
    redirect to('/')
  end

  post '/play/' do
    settings.game.play(params['word'])
    erb :play, locals: { game: settings.game }
  end

  get '/guess/?' do
    redirect to('/')
  end

  post '/guess/' do
    settings.game.guess(params['input'])
    erb :play, locals: { game: settings.game }
  end
end

HangmanController.run!
