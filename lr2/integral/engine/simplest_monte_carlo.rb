module Integral
  module Engine
    class SimplestMonteCarlo < Mode
      p self

      def compute(_data)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end
      
    end
  end
end