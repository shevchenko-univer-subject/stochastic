module Integral
  module Engine
    class GeometricMonteCarlo < Mode

      def compute_function(axis)
      # prepare
        abscissa_borders = @borders[axis]
        ordinate_borders = find_ordinate_borders_for(axis)

        amplitude_abscissa_borders = amplitude(abscissa_borders)
        amplitude_ordinate_borders = amplitude(ordinate_borders)

      # logic
        quantity_success = @quantity.times.select do
          abscissa = abscissa_borders.min + amplitude_abscissa_borders * rand(abscissa_borders)
          ordinate = ordinate_borders.min + amplitude_ordinate_borders * rand(abscissa_borders)

          @functions[axis].call(abscissa, @params[axis]) > ordinate
        end.count

      # result
        raw_result_numerator   = amplitude_abscissa_borders * amplitude_ordinate_borders * quantity_success 
        raw_result_denominator = @quantity  

        (raw_result_numerator / raw_result_denominator) + ordinate_borders.min
      end

      def compute_mistake
        raw_mistake = AXISES.map do |axis|
          ordinate_borders = find_ordinate_borders_for(axis)
          amplitude(@borders[axis]) * 
            amplitude(ordinate_borders) * 
            Math.sqrt(dispersion(axis) / @quantity)
        end.reduce(:+)
        @mistake = raw_mistake / 3.0
      end

      private
        def find_verge(verge, axis)
          func =    @functions[axis]
          borders = @borders[axis]
          params =  @params[axis]

          wanted = func.call(borders.max, params)
          @quantity.times do |val|
            val = amplitude(borders) / @quantity * val
            f = func.call(val, params)
            wanted = f if f.method(verge).call(wanted)
          end 
          wanted
        end

        def find_ordinate_borders_for(axis)
          min = find_verge(:<, axis)
          max = find_verge(:>, axis)
          min..max
        end
      
        def dispersion(axis)
            sum = @quantity.times.select do
              @functions[axis].call(rand(@borders[axis]), @params[axis]) > rand(@borders[axis])
            end.count

            (1.0 - sum.to_f / @quantity) * sum.to_f / @quantity
        end
    end
  end
end