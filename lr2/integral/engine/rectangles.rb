module Integral
  module Engine
    class Rectangles < Mode
      p self

      def self.compute_function(borders, func, quantity)
        sum = borders.quantity(quantity).map do |var|
          func.call(var)
        end.reduce(:+)
        sum * quantity
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

      def compute_mistake
        raise NameError, "undefined instance variable `@volume` for #{self.class}" if @volume.nil? 
        raw_mistake = AXISES.map do |axis|
          compute_function(@borders[axis], @functions[axis], @quantity) - 
            compute_function(@borders[axis], @functions[axis], @quantity*2)
        end.reduce(:+)
        
        @mistake = (raw_mistake/AXISES.size).abs
      end

      def compute_function(*args)
        self.class.compute_function(*args)
      end
    end
  end
end