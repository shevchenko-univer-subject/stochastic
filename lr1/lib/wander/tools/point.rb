module Wander
  module Tools
    class Point
      attr_reader :status, :position

      DIRECTIONS = %i[north east south west]
      STATUS = {
        moving: :moving, 
        stoped: :stoped
      }

      def initialize(start_position)
        @position = start_position
        @status = STATUS[:moving]

        collect_meta
      end

      def move
        return if cannot_move?
        move_to random_direction
      end

      private
        def move_to direction
          return status_stop unless valid_move? direction

          send(bang(direction))
          collect_meta(direction)
        end

        def valid_move? direction
          future_move = send(direction)
          @passed_points.none?(future_move)
        end

        def collect_meta(direction = nil)
          @passed_points ||= [] 
          @passed_points << @position
          @came_from = toggle(direction)
        end

        def random_direction
          actual_directions.sample
        end

        def actual_directions
          DIRECTIONS.reject { |e| @came_from.equal?(e) }
        end

        def cannot_move?
          [ STATUS[:stoped], STATUS[:exited] ].include?(@status)
        end

        def status_stop
          @status = STATUS[:stoped]
        end

        def status_exit
          @status = STATUS[:exited]
        end

        def bang(symbol)
          ((symbol.to_s) + '!').to_sym
        end

        def toggle side
          case side
          when :north
            :south
          when :south
            :north
          when :east
            :west
          when :west
            :east
          end
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
end