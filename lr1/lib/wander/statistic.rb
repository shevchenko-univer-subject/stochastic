module Wander
  class Statistic
    attr_reader :data
    
    def initialize(input_data)
      @meta_data = input_data[:meta_data]
      @input_data = input_data.reject { |e| e == :meta_data }

      @data = generate_data_from
    end

    def generate_data_from
      @input_data.keys.map do |st| 
        calc_q_for(st)
      end.reduce Hash.new, :merge
    end

    private
      def calc_q_for(situation)
        {
          "#{situation}": avarage_value(situation) 
        }
      end

      def avarage_value(situation) 
        @input_data[situation]/@meta_data[:n].to_f
      end
  end
end