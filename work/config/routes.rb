require 'sinatra/base'
require 'sinatra/json'

class Stochastic < Sinatra::Base
  get '/' do
    controller = Controllers::Application.index
    erb(controller.view_name)
  end

  get '/docs' do
    controller = Controllers::Application.docs
    erb(controller.view_name)
  end

  get '/process' do
    controller = Controllers::Application.process(request)
    json(controller.response)
  end
end