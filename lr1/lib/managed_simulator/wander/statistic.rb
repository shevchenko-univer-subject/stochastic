module ManagedSimulator
  module Wander
    class Statistic
      attr_reader :data, :meta, :probability

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
          @raw_data.keys.map do |kase| 
            collect_hash_of_results_for(kase)
          end.reduce Hash.new, :merge
        end

        def collect_hash_of_results_for(kase)
          {
            "#{kase}": {
              exit_prob:   calculate_exit_probability(kase),
              uncertainty: calculate_uncertainty(kase),
              delta: calculate_delta(kase),
              border: calculate_border(kase)
            }
          }
        end

        def calculate_exit_probability(kase)
          @raw_data[kase]/@meta[:sample_size].to_f
        end

        def calculate_uncertainty(kase)
          exit_prob = calculate_exit_probability(kase)
          Math.sqrt( exit_prob*(1-exit_prob) / @meta[:sample_size] )
        end

        def calculate_delta(kase)
          (@probability[kase] - calculate_exit_probability(kase)).abs
        end

        def calculate_border(kase)
          calculate_uncertainty(kase) * 3
        end
    end
  end
end