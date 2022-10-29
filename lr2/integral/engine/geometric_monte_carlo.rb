module Integral
  module Engine
    class GeometricMonteCarlo < Mode
      
      def compute_function(abscissa_borders, function, quantity)
        ordinate_borders = find_ordinate_borders(abscissa_borders, function)

        amplitude_abscissa_borders = amplitude(abscissa_borders)
        amplitude_ordinate_borders = amplitude(ordinate_borders)

        quantity_success = quantity.times.select do
          abscissa = abscissa_borders.min + amplitude_abscissa_borders * rand(abscissa_borders)
          ordinate = ordinate_borders.min + amplitude_ordinate_borders * rand(abscissa_borders)

          function.call(abscissa) > ordinate
        end.count

        raw_result_numerator   = amplitude_abscissa_borders * amplitude_ordinate_borders * quantity_success 
        raw_result_denominator = quantity  

        (raw_result_numerator / raw_result_denominator) + ordinate_borders.min
      end

      def compute_mistake
        raw_mistake = AXISES.map do |axis|
          ordinate_borders = find_ordinate_borders(@borders[axis], @functions[axis])
          amplitude(@borders[axis]) * 
            amplitude(ordinate_borders) * 
            Math.sqrt(dispersion(axis) / @quantity)
        end.reduce(:+)
        @mistake = raw_mistake / 3.0
      end

      private
        def find_verge(verge, borders, func)
          wanted = func.call(borders.max)
          @quantity.times do |val|
            f = func.call(amplitude(borders) / @quantity * val)
            wanted = f if f.method(verge).call(wanted)
          end 
          wanted
        end

        def find_ordinate_borders(borders, function)
          find_verge(:<, borders, function)..find_verge(:>, borders, function)
        end
      
        def dispersion(axis)
            sum = @quantity.times.select do
              @functions[axis].call(rand(@borders[axis])) > rand(@borders[axis])
            end.count

            (1.0 - sum.to_f / @quantity) * sum.to_f / @quantity
        end
    end
  end
end