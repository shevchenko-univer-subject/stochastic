require 'sinatra/base'
require 'sinatra/json'

require "#{controllers}/controller"

class Stochastic < Sinatra::Base
  get '/' do
    controller = Controller.index
    erb(controller.view_name)
  end

  get '/docs' do
    controller = Controller.docs
    erb(controller.view_name)
  end

  get '/process' do
    controller = Controller.process(request)
    json(controller.response)
  end
end