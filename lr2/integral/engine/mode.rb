module Integral
  module Engine
    AXISES = %i[x y z]

    class Mode
      def self.compute(*args)
        new(*args).compute
      end

      def self.compute_function(_borders, _func, _quantity: nil)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def initalize(_borders, _functions, _quantity)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def compute
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def compute_volume
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def compute_mistake
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def compute_function(_borders, _func, _quantity)
        self.class.compute_function
      end 
    end
  end
end
