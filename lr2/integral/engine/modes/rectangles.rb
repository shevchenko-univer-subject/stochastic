module Integral
  module Engine
    class Rectangles < Mode

      def compute_function(axis, quantity: nil)
        sum = @borders[axis].step(quantity || @quantity).map do |var|
          @functions[axis].call(var, @params[axis])
        end.reduce(:+)
        sum * @quantity
      end

      def compute_mistake
        raise NameError, "undefined instance variable `@volume` for #{self.class}" if @volume.nil? 
        raw_mistake = AXISES.map do |axis|
          compute_function(axis) - compute_function(axis, quantity: @quantity * 2)
        end.reduce(:+)
        
        @mistake = (raw_mistake/AXISES.size).abs
      end
    end
  end
end