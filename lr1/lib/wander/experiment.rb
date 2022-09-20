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
      @statistic_data.dig(:meta_data, :n).times do 
        build_point
        run_point
        analize_path_of_point
      end 
      return self
    end

    private

    attr_accessor :point

    def run_point
      point.move while point.status == :moving && @space.has?(point.position)
    end

    def build_point
      point = Tools::Point.new(@space.start_position)
    end

    def analize_path_of_point
      return @statistic_data[:stoped] += 1 if point.status == :stoped

      side = @space.calculate_side(point.position)
      @statistic_data[side] += 1
    end
  end
end