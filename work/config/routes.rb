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
    controller = CONTROLLERS::Application.csv_create(request)
    json(controller.response)
  end
end
