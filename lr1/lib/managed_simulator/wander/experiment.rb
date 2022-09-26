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
          stopped: 0,
          north: 0,
          south: 0,
          east: 0,
          west: 0
        }
      end

      def call
        set_start_position
        recalc_probability_for_sides

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
        def random_situation
          rand_v = Random.rand(@probability.values.sum)
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

        def set_start_position
          @start_position = {
            x: Random.rand(@meta.dig(:space_size, :x)),
            y: Random.rand(@meta.dig(:space_size, :y))
          }
        end
        def recalc_probability_for_sides
          koef = {
            north:                                @start_position[:y] /@meta.dig(:space_size, :y).to_f,
            south:  (@meta.dig(:space_size, :y) - @start_position[:y])/@meta.dig(:space_size, :y).to_f,
            east:                                 @start_position[:x] /@meta.dig(:space_size, :x).to_f,
            west:   (@meta.dig(:space_size, :x) - @start_position[:x])/@meta.dig(:space_size, :x).to_f
          }
          koef.keys.each do |side|
            @probability[side] *= koef[side]*10
          end
        end
    end
  end
end
