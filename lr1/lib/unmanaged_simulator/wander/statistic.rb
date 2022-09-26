module UnmanagedSimulator
  module Wander
    class Statistic
      attr_reader :data, :meta

      def initialize(data)
        @meta = data[:meta]
        @raw_data  = data.reject { |e| e == :meta }

        @data = process_raw_data
      end

      private
        def process_raw_data
          @raw_data.keys.map do |situation| 
            calc_q_for(situation) 
          end.reduce Hash.new, :merge
        end

        def calc_q_for(situation)
          {
            "#{situation}": avarage_value(situation) 
          }
        end

        def avarage_value(situation) 
          @raw_data[situation]/@meta[:sample_size].to_f
        end
    end
  end
end
