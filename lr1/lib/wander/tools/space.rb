module Wander
  module Tools
    class Space
      attr_reader :start_position

      def initialize(options = {})
        @border_along_x = options.fetch(:x)
        @border_along_y = options.fetch(:y) 

        @start_position = random_start_position
      end

      def has?(point)
        correct_along_axis(:x, point) && correct_along_axis(:y, point)
      end

      def calculate_side(point)
        if    point[:x] > @border_along_x
          :south
        elsif point[:x] < 0
          :north
        elsif point[:y] > @border_along_y
          :east
        elsif point[:y] < 0
          :west
        end
      end

      private

        def correct_along_axis(axis, point)  
          eval "#{point[axis]}.between?(0, @border_along_#{axis})"
        end


        def random_start_position
          @start_position = {
            x: Random.rand(@border_along_x),
            y: Random.rand(@border_along_y)
          }
        end
    end
  end
end
