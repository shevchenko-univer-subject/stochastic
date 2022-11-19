require 'sinatra/base'

class Stochastic < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/docs' do
    erb :docs
  end
end