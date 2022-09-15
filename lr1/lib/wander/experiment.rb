require_relative 'tools/space'
require_relative 'tools/point'

module Wander
  class Experiment
    attr_reader :statistic_data
    def self.call(*args)
      new(*args).call
    end

    def initialize(options = {})
      @space = Tools::Space.new(options.fetch(:space_size))

      @statistic_data = {
        meta_data: {
          n: options.fetch(:n)
        },
        stoped: 0,
        north: 0,
        south: 0,
        east: 0,
        west: 0
      }
    end

    def call
      @statistic_data.dig(:meta_data, :n).times { iteration } 
      self
    end

    private

    def iteration
      point = Tools::Point.new(@space.start_position)
      point.move while point.status == :moving && @space.has?(point.position)

      analize point
    end

    def analize point
      return @statistic_data[:stoped] += 1 if point.status == :stoped

      side = @space.calculate_side(point.position)
      @statistic_data[side] += 1
    end
  end
end