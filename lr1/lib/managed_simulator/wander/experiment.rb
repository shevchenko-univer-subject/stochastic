module ManagedSimulator
  module Wander
    class Experiment
      def self.call(*args)
        new(*args).call
      end

      def initialize(data)
        @meta = data[:meta]
        @probability = data[:probability]
        @result = {
          stoped: 0,
          north: 0,
          south: 0,
          east: 0,
          west: 0
        }
      end

      def call
        validate_probability_data

        sample_size.times do 
          record_result(random_situation)
        end
        return self
      end

      def collected_data
        {
          meta: @meta,
          probability: @probability,
          result: @result
        }
      end
      
      private
        def validate_probability_data
          raise 'Sum of probability should to be equal 1' unless @probability.values.sum == 1
        end

        def random_situation
          rand_v = Random.rand
          from = 0; to = 0

          @probability.each do |situation, prob|
            from = to; to += prob
            return situation if rand_v.between?(from, to)
          end
        end

        def record_result situation
          @result[situation] += 1
        end

        def sample_size
          @meta[:sample_size]
        end
    end
  end
end
