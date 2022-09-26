module ManagedSimulator
  require_relative 'wander/experiment'
  require_relative 'wander/statistic'

  puts 'Hi. Lets model a point random wandering'

  print 'Do you want set custom probability values?(y,n) '

  data = if gets.chomp == 'y'
    empty_data = {
      meta: {
        sample_size: nil
      },
      probability: {
        north:  nil,
        south:  nil,
        east:   nil,
        west:   nil,
        stopped: nil
      }
    }

    print 'Monte-Carlo sample size is '
    empty_data[:meta].merge!(sample_size: gets.chomp.to_i)

    %i[north south east west stopped].each do |el|
      print "probability #{el}\t= "
      value = gets.chomp.to_f
      empty_data[:probability].merge!({"#{el}": value})
    end
    empty_data
  else
    {
      meta: {
        sample_size: 10000
      },
      probability: {
        north:  0.25,
        south:  0.25,
        east:   0.25,
        west:   0.25,
        stopped: 0
      }
    }
  end

  puts "\n"
  puts "Monte-Carlo sample size is #{data[:meta][:sample_size]}"
  puts "Probability values is #{data[:probability].inspect}"

  puts "\n"
  puts 'Running...' 
  experiment = Wander::Experiment.call(data)

  puts 'Process...'
  statistic = Wander::Statistic.call(experiment.collected_data)
  puts "\n"

  puts 'Info: '
  statistic.data.keys.each do |el|
    puts "\t #{el.capitalize}: "
    puts "\t\t Exit probability #{statistic.data[el][:exit_prob]}"
    puts "\t\t Uncertaity #{statistic.data[el][:uncertainty]}"
  end
end
