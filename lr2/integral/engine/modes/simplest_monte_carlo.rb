module Integral
  module Engine
    class SimplestMonteCarlo < Mode

      def compute_function(axis)
        sum = @quantity.times.map do
          @functions[axis].call(rand(@borders[axis]), @params[axis])
        end.reduce(:+)
        amplitude(@borders[axis]).to_f * sum.to_f / @quantity.to_f
      end

      def compute_mistake
        raise NameError, "undefined instance variable `@volume` for #{self.class}" if @volume.nil? 
        raw_mistake = AXISES.map do |axis|
          amplitude(@borders[axis]) * Math.sqrt(dispersion(axis))
        end.reduce(:+)
        @mistake =  raw_mistake / 3.0
      end

      private
        def dispersion(axis)
          sum = {smpl: 0, pow2: 0}
          @quantity.times do
            f = @functions[axis].call(rand(@borders[axis]), @params[axis])
            sum[:smpl] += f
            sum[:pow2] += f ** 2
          end

          raw_dispersion1 =  sum[:pow2] / @quantity.to_f 
          raw_dispersion2 = (sum[:smpl] / @quantity.to_f) ** 2

          (raw_dispersion1 - raw_dispersion2) / @quantity.to_f
        end
    end
  end
end