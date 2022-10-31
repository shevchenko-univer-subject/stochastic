module Integral
  module Engine
    class Direct < Mode
      WITHOUT_MISTAKE = 0

      def initialize(*args)
        args.first[:quantity] = nil
        super(*args)
      end

      def compute_function(axis) # TODO
        defirencial_functions = get_default_defirencial_functions 
        defirencial_functions[axis].call(@borders[axis].max, @params[axis]) - 
          defirencial_functions[axis].call(@borders[axis].min, @params[axis])
      end

      def compute_mistake
        @mistake = WITHOUT_MISTAKE
      end

      private
        def get_default_defirencial_functions
          
          {
            x: -> (x, param) { -param[:a] * (x ** 2.0) * (2.0 * x - 3.0) / 6.0 },
            y: -> (y, param) { -Math.exp(-param[:m] * y) / param[:m] },
            z: -> (z, param) { -Math.cos(Math::PI * param[:k] * z) / (Math::PI * param[:k]) }
          }
        end

    end    
  end
end
