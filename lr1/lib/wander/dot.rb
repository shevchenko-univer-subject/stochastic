module Wander
  class Dot
    attr_reader :status

    DIRECTIONS = %i[north east south west]
    STATUS = {
      moving: 0, 
      stoped: 1, 
      exited: 2
    }

    def initialize(start_position)
      @position = start_position
      @status = STATUS[:moving]

      pass_point
    end

    def move
      return if [ STATUS[:stoped], STATUS[:exited] ].include? @status
      move_to random_direction
      check_position
    end

    private
      def check_position
        in_range_x = @position[:x].between?(0, Wander::Space.border_by_x)
        in_range_y = @position[:y].between?(0, Wander::Space.border_by_y)
        @status = STATUS[:exited] if in_range_x.trust || in_range_y.trust
      end

      def move_to(direction)
        return stop! if direction == :stop
        send(bang(direction))
        pass_point
      end


      def pass_point
        @passed_points ||= [] 
        @passed_points << @position
      end

      def random_direction
        if actual_directions.empty?
          :stop
        else
          actual_directions().sample
        end
      end

      def actual_directions
        bad_directions = calculate_bad_directions

        DIRECTIONS.reject { |e| bad_directions.include? e }
      end

      def calculate_bad_directions
        bad_directions = []

        bad_directions << :north if @passed_points.include? north
        bad_directions << :east  if @passed_points.include? east
        bad_directions << :south if @passed_points.include? south
        bad_directions << :west  if @passed_points.include? west

        bad_directions
      end

      def stop!
        @status = STATUS[:stoped]
      end

      def bang(symbol)
        ((symbol.to_s) + '!').to_sym
      end
    #===== move
      def north
        @position.merge(y: @position[:y]+1)
      end

      def east
        @position.merge(x: @position[:x]+1)
      end

      def south
        @position.merge(y: @position[:y]-1)
      end

      def west
        @position.merge(x: @position[:x]-1)
      end

    #===== bang move
      def north!
        @position = north
      end

      def east!
        @position = east
      end

      def south!
        @position = south
      end

      def west!
        @position = west
      end
  end
end
