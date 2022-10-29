require_relative 'engine/mode'
require_relative "engine/direct"
require_relative "engine/rectangles"
require_relative "engine/simplest_monte_carlo"
require_relative "engine/geometric_monte_carlo"

module Integral
  class Calculator
    p self
    attr_accessor :engine

    def initialize(engine)
      @engine = engine
    end
    
    def procces
      result = @engine.compute
    end
  end
end