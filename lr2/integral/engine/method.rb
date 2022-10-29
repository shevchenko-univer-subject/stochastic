require_relative "methods/direct"
require_relative "methods/rectangles"
require_relative "methods/simplest_monte_carlo"
require_relative "methods/geometric_monte_carlo"

module Integral
  module Engine
    class Method

      def self.compute(*args)
        new(*args).compute
      end

      def self.compute_function(_borders, _func, _step)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def initalize(_borders, _functions, _step)
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

      def compute_function(_borders, _func, _step)
        self.class.compute_function
      end 
    end
  end
end
