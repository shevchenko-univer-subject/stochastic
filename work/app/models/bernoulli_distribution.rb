require 'sinatra/base'

class Stochastic < Sinatra::Base  
  module Models
    class BernoulliDistribution
      attr_accessor(
        :cdf,
        :pdf,
        :mean,
        :mode
      )

      attr_reader :result
      
      def process 
        @result = build_result
      end

      private

      def build_result
        {
          x: [0, 1, 2, 3, 4, 5],
          y: [0, 1, 3, 3, 1, 0]
        }
      end
    end
  end
end