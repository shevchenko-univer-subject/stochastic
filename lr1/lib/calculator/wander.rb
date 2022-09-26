module Calculator
  require_relative 'wander/experiment'
  require_relative 'wander/statistic'

  data = {
    meta: {
      sample_size: 10000
    },
    probability: {
      north:  0.25,
      south:  0.25,
      east:   0.25,
      west:   0.25,
      stoped: 0
    }
  }

  experiment = Wander::Experiment.call(data)
  p experiment.collected_data
end