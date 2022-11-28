require 'sinatra/base'
require 'sinatra/json'

class Stochastic < Sinatra::Base
  get '/' do
    controller = CONTROLLERS::Application.index
    erb(controller.view_name)
  end

  get '/docs' do
    controller = CONTROLLERS::Application.docs
    erb(controller.view_name)
  end

  get '/process' do
    controller = CONTROLLERS::Application.process(request)
    json(controller.response)
  end

  post '/export/create' do 
    answer = { link: 'http://localhost:9292/export/test' }
    json answer
  end

  get '/export/destroy' do 

  end
end
