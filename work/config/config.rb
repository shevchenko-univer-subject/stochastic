require 'sinatra/base'
require 'pathname'

class Stochastic < Sinatra::Base  
  configure do
    set :root, Pathname.new(__dir__).parent
    set :views, root.join('app', 'views')

    set :erb, :layout => :'layouts/application'
  end
end
