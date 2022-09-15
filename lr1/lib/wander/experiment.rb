require_relative 'tools/space'
require_relative 'tools/point'

module Wander
  class Experiment
    attr_reader :statistic
    def self.call(*args)
      new(*args).call
    end

    def initialize(options = {})
      @n = options.fetch(:n)
      @space = Tools::Space.new(options.fetch(:space_size))

      @statistic = {
        stoped: 0,
        north: 0,
        south: 0,
        east: 0,
        west: 0
      }
    end

    def call
      @n.times { iteration } 
      self
    end

    private

    def iteration
      point = Tools::Point.new(@space.start_position)
      point.move while point.status == :moving && @space.has?(point.position)

      analize point
    end

    def analize point
      return @statistic[:stoped] += 1 if point.status == :stoped

      side = @space.calculate_side(point.position)
      @statistic[side] += 1
    end
  end
end