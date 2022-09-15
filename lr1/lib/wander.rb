require_relative 'wander/experiment'

space_size = {
  x: 20, 
  y: 30
}

exited_points_count = Wander::Experiment.call(space: space_size, n: 10000)

