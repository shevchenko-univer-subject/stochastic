module Integral
  module Engine
    class Rectangles < Mode

      def compute_function(borders, func, quantity)
        sum = borders.step(quantity).map do |var|
          func.call(var)
        end.reduce(:+)
        sum * quantity
      end

      def compute_mistake
        raise NameError, "undefined instance variable `@volume` for #{self.class}" if @volume.nil? 
        raw_mistake = AXISES.map do |axis|
          compute_function(@borders[axis], @functions[axis], @quantity) - 
            compute_function(@borders[axis], @functions[axis], @quantity*2)
        end.reduce(:+)
        
        @mistake = (raw_mistake/AXISES.size).abs
      end
    end
  end
end