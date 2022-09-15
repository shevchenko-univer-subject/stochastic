require_relative 'space'
require_relative 'dot'

module Wander
  class Experiment
    def self.call(*args)
      new(*args).call
    end

    def initialize(options = {})
      @n = options.fetch(:n)
      @space_size = options.fetch(:space)
    end

    def call
      space = Wander::Space.new(@space_size)
      iteration(space) 
    end

    private

    def iteration(space)
      dot = Wander::Dot.new(space)
      p dot.status
       while dot.status == :moving
          dot.move
          p dot
        end
    end
  end
end