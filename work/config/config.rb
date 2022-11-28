require 'sinatra/cross_origin'

class Stochastic < Sinatra::Base
  MODELS = Models
  CONTROLLERS = Controllers
  
  configure do
    set :root,          Pathname.new(__dir__).parent
    set :views,         root.join('app', 'views')
    set :export,        root.join('export')

    set :erb, :layout => :'layouts/application'
  end
end
