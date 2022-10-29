module Integral
  module Engine
    module Methods
      class Rectangles < Method
        def self.compute_function(borders, func, step)
          sum = 0
          borders.step(step) do |variable|
            sum += func.call(variable)
          end
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
          s_yz  = compute_function(@borders[:x], @functions[:x], @step)
          s_xz  = compute_function(@borders[:y], @functions[:y], @step)
          s_xy  = compute_function(@borders[:z], @functions[:z], @step)
          @volume = s_xy*s_xz*s_yz
        end

        def compute_mistake
          raise NameError, "undefined instance variable `@volume` for #{self.class}" if @volume.nil? 

          s_2yz = compute_function(@borders[:x], @functions[:x], @step*2)
          s_2xz = compute_function(@borders[:y], @functions[:y], @step*2)
          s_2xy = compute_function(@borders[:z], @functions[:z], @step*2)
          
          volume2 = s_2yz * s_2xz * s_2xy
          @mistake = volume2 - @volume
        end

        def compute_function
          self.class.compute_function
        end        
      end
    end
  end
end