require_relative 'engine/method'

module Integral
  class Calculator
    p self
    attr_writer :engine

    def initialize(engine)
      @engine = engine
    end
    
    def procces(func, params)
      result = @engine.calculate(func, params)
    end
  end
end