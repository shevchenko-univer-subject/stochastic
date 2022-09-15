module Wander
  class Space
    attr_reader :border_by_x, :border_by_y, :start_position

    def initialize(options = {})
      @border_by_x = options.fetch(:x)
      @border_by_y = options.fetch(:y) 

      @start_position = random_start_position
    end

    private

    def random_start_position
      @start_position = {
        x: Random.rand(@border_by_x),
        y: Random.rand(@border_by_y)
      }
    end
  end
end
