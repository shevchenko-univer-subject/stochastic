require_relative 'mode_abstract'

module Integral
  module Engine
    AXISES = %i[x y z]

    class Mode
      prepend ModeAbstract if self.is_a? Mode

      attr_reader :volume, :mistake, :quantity
      
      def self.compute(*args)
        new(*args).compute
      end

      def initialize(functions_data, quantity)
        @functions = functions_data[:functions]
        @params =    functions_data[:params]
        @borders =   functions_data[:borders]

        @quantity = quantity

        @volume = nil
        @mistake = nil
      end

      def compute
        compute_volume
        compute_mistake
        true
      end

      def compute_volume
        @volume = AXISES.map do |axis|
          compute_function(axis)
        end.reduce(:*)
      end

      private
        def amplitude(range)
          (range.max.to_f - range.min.to_f).abs
        end
    end
  end
end
