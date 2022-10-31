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
        defirencial_functions[axis].call(@borders[axis].max) - 
          defirencial_functions[axis].call(@borders[axis].min)
      end

      def compute_mistake
        @mistake = WITHOUT_MISTAKE
      end

      private
        def get_default_defirencial_functions
          param = 1.0
          {
            x: -> (x) { -param * (x ** 2.0) * (2.0 * x - 3.0) / 6.0 },
            y: -> (y) { -Math.exp(-param * y) / param },
            z: -> (z) { -Math.cos(Math::PI * param * z) / (Math::PI * param) }
          }
        end

    end    
  end
end
