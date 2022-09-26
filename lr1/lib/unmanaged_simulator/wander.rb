module UnmanagedSimulator
  require_relative 'wander/experiment'
  require_relative 'wander/statistic'

  puts 'Hi. Lets model a point random wandering'
  puts "Set space size"

  print 'x = '
  x = gets.chomp.to_i

  print 'y = '
  y = gets.chomp.to_i

  print 'Monte-Carlo sample size is '
  sample_size = gets.chomp.to_i

  space_size = {
    x: x, 
    y: y
  }

  puts 'Running...'
  experiment = Wander::Experiment.call(space_size: space_size, sample_size: sample_size)

  puts 'Process...'
  statistic  = Wander::Statistic.new(experiment.statistic_data)

  print "Start position was "
  puts "[x = #{statistic.meta[:start_position][:x]}, y = #{statistic.meta[:start_position][:y]}]"

  puts "q for north: #{statistic.data[:north]}"
  puts "q for south: #{statistic.data[:south]}"
  puts "q for east:  #{statistic.data[:east]}"
  puts "q for west:  #{statistic.data[:west]}"
  puts "q stopped:   #{statistic.data[:stopped]}"
end