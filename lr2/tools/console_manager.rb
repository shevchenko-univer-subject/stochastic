module Tools
  module ConsoleManager
    extend ConsoleManager
    
    def input str
      print str
      STDIN.gets
    end

    def input_f str
      input(str).to_f
    end

    def output str
      puts str
    end
  end
end