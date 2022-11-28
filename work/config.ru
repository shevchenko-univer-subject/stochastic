require 'sinatra/base'
require 'pry'
require 'pathname'

# Models
require './app/models/bernoulli_distribution'
require './app/models/csv_creator'

# Controllers
require './app/controllers/application'

# Configs
require './config/config'
require './config/routes'


run Stochastic