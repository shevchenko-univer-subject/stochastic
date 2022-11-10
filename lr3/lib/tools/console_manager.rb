# frozen_string_literal: true

module Tools
  module ConsoleManager
    extend ConsoleManager

    def input(str)
      print str
      $stdin.gets
    end

    def input_f(str)
      input_data = input(str).to_f
      return nil if input_data.zero?

      input_data
    end

    def input_i(str)
      input_data = input(str).to_i
      return nil if input_data.zero?

      input_data
    end

    def output(str)
      puts str
    end
  end
end
