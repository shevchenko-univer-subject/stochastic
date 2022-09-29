module ManagedSimulator
  require_relative 'wander/experiment'
  require_relative 'wander/statistic'

  def run  
    puts 'Hi. Lets model a point random wandering'

    print 'Do you want set custom probability values?(y,n) '

    data = if STDIN.gets.chomp == 'y'
      get_data_from_term_form    
    else
      default_data
    end

    print_data

    puts "\n"
    puts 'Running...' 
    experiment = Wander::Experiment.call(data)

    puts 'Process...'
    statistic = Wander::Statistic.call(experiment.collected_data)
    puts "\n"

    print_statistic_info(statistic)
  end
  
  private
    def print_statistic_info(statistic)
      statistic.data.keys.each do |el|
        puts 'Info: '
          puts "\t #{el.capitalize}: "
          puts "\t\t Exit probability #{statistic.data[el][:exit_prob]}"
          puts "\t\t Uncertaity #{statistic.data[el][:uncertainty]}"
      end
    end

    def print_data
      puts "\n"
      puts "Monte-Carlo sample size is #{data[:meta][:sample_size]}"
      puts "Probability values is #{data[:probability].inspect}"
      puts "Start position is #{data[:meta][:start_position]}"
    end

    def default_data
      {
        meta: {
          sample_size: 10000,
          space_size: {
            x: 10,
            y: 10
          },
          start_position: {
            x: 5,
            y: 5
          }
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

    def get_data_from_term_form
      empty_data = {
        meta: {
          sample_size: nil,
          space_size: nil,
          start_position: nil
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
        empty_data[:meta].merge!(sample_size: STDIN.gets.chomp.to_i)

      puts "Space size is"
        print "\tx = "
        x = STDIN.gets.chomp.to_i
        print "\ty = "
        y = STDIN.gets.chomp.to_i
        empty_data[:meta].merge!(space_size: {x: x, y: y})

      puts "Start position is"
        print "\tx = "
        x = STDIN.gets.chomp.to_i
        print "\ty = "
        y = STDIN.gets.chomp.to_i
        empty_data[:meta].merge!(start_position: {x: x, y: y})

      %i[north south east west stopped].each do |el|
        print "probability #{el}\t= "
        value = STDIN.gets.chomp.to_f
        empty_data[:probability].merge!({"#{el}": value})
      end
      empty_data
    end
end
