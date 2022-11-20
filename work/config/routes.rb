require 'sinatra/base'
require 'sinatra/json'

class Stochastic < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/docs' do
    erb :docs
  end

  get '/process' do
    json [4,5,6,7,8,8,3]
  end
end