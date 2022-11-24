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
        @result = [1,2,3,4,7,3,2]
      end
    end
  end
end