class Stochastic < Sinatra::Base  
  module Models
    class CsvCreator
      require 'csv'

      attr_accessor :table
      attr_reader :name, :export_path

      def initialize
        @export_path = ::Stochastic.root.join('public', 'export')
        if block_given?
          yield(self) 
        else
          raise "need initialize object by block"
        end
      end

      def create
        prepare_name!
        prepare_table!
        build_file
      end

      private

      def build_file
        CSV.open("#{export_path}/#{name}", 'a+') do |csv_file|
          @table.each do |row|
            csv_file << row
          end
        end
      end

      def prepare_name!
        @name = "Stochastic-#{rand}.csv"
      end

      def prepare_table!
        @table = @table.map do |axis, values|
          arr = [] << axis.to_s
          arr << values
          arr.flatten
        end 
      end
    end
  end
end
