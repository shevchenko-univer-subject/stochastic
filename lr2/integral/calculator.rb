require_relative 'engine/mode'
require_relative "engine/direct"
require_relative "engine/rectangles"
require_relative "engine/simplest_monte_carlo"
require_relative "engine/geometric_monte_carlo"

module Integral
  class Calculator

    attr_accessor :engine

    def initialize(engine = nil)
      @engine = engine
    end
    
    def procces
      result = @engine.compute
    end
  end
end