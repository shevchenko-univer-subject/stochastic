module Wander
  class Statistic
    attr_reader :data
    
    def initialize(statistic_input_data, n)
      @n = n
      @statistic_input_data = statistic_input_data
      @data = generate_data_from
    end

    def generate_data_from
      @statistic_input_data.keys.map {|st| calc_q_for(st)}
    end

    private
      def calc_q_for(situation)
        {
          "#{situation}": @statistic_input_data[situation]/@n.to_f
        }
      end
  end
end