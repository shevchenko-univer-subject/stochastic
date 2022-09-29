module ManagedSimulator
  module Wander
    class Experiment
      def self.call(*args)
        new(*args).call
      end

      def initialize(data)
        @meta = data[:meta]
        set_probability_take_about_positions(data[:probability])

        @result = {
          stopped: 0,
          north: 0,
          south: 0,
          east: 0,
          west: 0
        }
      end

      def call
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

          @probability.each do |kase, prob|
            from = to; to += prob
            return kase if rand_v.between?(from, to)
          end
        end

        def record_result kase
          @result[kase] += 1
        end

        def sample_size
          @meta[:sample_size]
        end

        def set_probability_take_about_positions(raw_probability)
          @probability = {
            north:                                @meta.dig(:start_position, :y) /@meta.dig(:space_size, :y).to_f,
            south:  (@meta.dig(:space_size, :y) - @meta.dig(:start_position, :y))/@meta.dig(:space_size, :y).to_f,
            east:                                 @meta.dig(:start_position, :x) /@meta.dig(:space_size, :x).to_f,
            west:   (@meta.dig(:space_size, :x) - @meta.dig(:start_position, :x))/@meta.dig(:space_size, :x).to_f
          }
          @probability.keys.each do |side|
            @probability[side] *= raw_probability[side]
          end

          @probability.merge!(stopped: raw_probability[:stopped])
          normalize_probability
        end

        def normalize_probability
          nomalization_koef = 1/@probability.values.sum

          @probability.keys.each do |kase|
            @probability[kase] *= nomalization_koef
          end
        end
    end
  end
end
