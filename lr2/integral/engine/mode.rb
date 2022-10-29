require_relative 'mode_abstract'

module Integral
  module Engine
    AXISES = %i[x y z]

    class Mode
      prepend ModeAbstract if self.is_a? Mode
      
      def self.compute(*args)
        new(*args).compute
      end

      def initialize(borders, functions, quantity)
        @functions = functions
        @borders = borders
        @quantity = quantity
        
        @volume = nil
        @mistake = nil
      end

      def compute
        compute_volume
        compute_mistake
      end

      def compute_volume
        @volume = AXISES.map do |axis|
          compute_function(@borders[axis], @functions[axis], @quantity)
        end.reduce(:*)
      end

      def compute_function(*args)
        self.class.compute_function(*args)
      end 

      private
        def self.amplitude(range)
          range.max.to_f - range.min.to_f
        end

        def amplitude(range)
          self.class.amplitude(range)
        end
    end
  end
end
