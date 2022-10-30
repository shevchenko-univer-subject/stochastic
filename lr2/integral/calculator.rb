require_relative 'engine/mode'
require_relative "engine/direct"
require_relative "engine/rectangles"
require_relative "engine/simplest_monte_carlo"
require_relative "engine/geometric_monte_carlo"

module Integral
  class Calculator

    attr_writer :engine

    def initialize(engine = nil)
      @engine = engine
    end
    
    def procces
      @engine.compute
    end

    def result
      procces if @engine.volume.nil?
      
      {
        mode:     @engine.class,
        volume:   @engine.volume,
        mistake:  @engine.mistake,
        quantity: @engine.quantity
      }
    end
  end
end