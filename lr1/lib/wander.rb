require_relative 'wander/experiment'
require_relative 'wander/statistic'

space_size = {
  x: 10, 
  y: 10
}

sample_size = 10000

experiment = Wander::Experiment.call(space_size: space_size, sample_size: sample_size)
statistic  = Wander::Statistic.new(experiment.statistic_data)

p statistic.data