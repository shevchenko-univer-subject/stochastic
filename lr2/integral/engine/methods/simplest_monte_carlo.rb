module Integral
  module Engine
    module Methods
      class SimplestMonteCarlo < Method
        p self

        def compute(_data)
          raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end
        
      end
    end
  end
end