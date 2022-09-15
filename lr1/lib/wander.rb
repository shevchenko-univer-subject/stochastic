require_relative 'wander/experiment'
require_relative 'wander/statistic'

space_size = {
  x: 10, 
  y: 10
}

n = 10000

experiment = Wander::Experiment.call(space_size: space_size, n: 1000)
statistic = Wander::Statistic.new(experiment.statistic_data)

p statistic.data