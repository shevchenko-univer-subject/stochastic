module ManagedSimulator
  module Wander
    class Statistic
      attr_reader :data

      def self.call(*args)
        new(*args).call
      end

      def initialize(data)
        @meta = data[:meta]
        @raw_data = data[:result]
        @probability = data[:probability]
        @data = nil
      end

      def call 
        @data = process_raw_data 
        return self
      end

      private
        def process_raw_data 
          @raw_data.keys.map do |situation| 
            collect_hash_of_results_for(situation)
          end.reduce Hash.new, :merge
        end

        def collect_hash_of_results_for(situation)
          {
            "#{situation}": {
              exit_prob:   calculate_exit_probability(situation),
              uncertainty: calculate_uncertainty(situation)
            }
          }
        end

        def calculate_exit_probability(situation)
          @raw_data[situation]/@meta[:sample_size].to_f
        end

        def calculate_uncertainty(situation)
          exit_prob = calculate_exit_probability situation
          Math.sqrt( exit_prob*(1-exit_prob) / @meta[:sample_size] )
        end
    end
  end
end