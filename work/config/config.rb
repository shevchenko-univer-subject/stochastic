require 'sinatra/base'
require 'pathname'
require 'sinatra/cross_origin'

class Stochastic < Sinatra::Base
  MODELS = Models
  CONTROLLERS = Controllers
  
  set :bind, '0.0.0.0'

  configure do
    enable :cross_origin

    set :root,          Pathname.new(__dir__).parent
    set :views,         root.join('app', 'views')
    set :export,        root.join('export')

    set :erb, :layout => :'layouts/application'
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end
  
  options "*" do
    response.headers["Allow"] = "POST"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end
end
