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
      iteration space.start_position
    end

    private

    def iteration(start_position)
      dot = Wander::Dot.new(start_position)
      
      while dot.status == :moving
        dot.move
      end
    end
  end
end