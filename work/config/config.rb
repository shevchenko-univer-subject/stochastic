require 'sinatra/base'
require 'pathname'

class Stochastic < Sinatra::Base  
  configure do
    set :root,          Pathname.new(__dir__).parent
    set :models,        root.join('app',' model')
    set :views,         root.join('app', 'views')
    set :controllers,   root.join('app',' controller')
    set :public_folder, root.join('public')

    set :erb, :layout => :'layouts/application'
  end
end
