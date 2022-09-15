require_relative 'wander/experiment'

space_size = {
  x: 10, 
  y: 10
}

experiment = Wander::Experiment.new(space_size: space_size, n: 10000)
experiment.call

p experiment