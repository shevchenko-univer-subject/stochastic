module Integral
  module Engine
    class Rectangles < MethodX
      p self

      def self.compute_function(borders, func, step)
        sum = borders.step(step).map do |var|
          func.call(var)
        end.reduce(:+)
        sum * step
      end

      def initialize(borders, functions, step)
        @functions = functions
        @borders = borders
        @step = step
        
        @volume = nil
        @mistake = nil
      end

      def compute
        compute_volume
        compute_mistake
      end

      def compute_volume
        @volume = AXISES.map do |axis|
          compute_function(@borders[axis], @functions[axis], @step)
        end.reduce(:*)
      end

      def compute_mistake
        raise NameError, "undefined instance variable `@volume` for #{self.class}" if @volume.nil? 
        raw_mistake = AXISES.map do |axis|
          compute_function(@borders[axis], @functions[axis], @step) - 
            compute_function(@borders[axis], @functions[axis], @step*2)
        end.reduce(:+)
        
        @mistake = (raw_mistake/AXISES.size).abs
      end

      def compute_function(*args)
        self.class.compute_function(*args)
      end
    end
  end
end