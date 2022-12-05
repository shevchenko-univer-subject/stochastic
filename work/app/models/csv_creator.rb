class Stochastic < Sinatra::Base  
  module Models
    class CsvCreator
      require 'csv'

      attr_accessor :values, :table
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
        @name = "Stochastic-#{Time.now.strftime("%d%m%Y-%H%M")}.csv"
      end

      def prepare_table!
        @table = @values[:chart.to_s].map do |axis, values|
          arr = [] << axis.to_s
          arr << values
          arr.flatten
        end 

        @table << ["Expect mean",      @values[:meta.to_s][:expect_mean.to_s]]
        @table << ["Actual mean",      @values[:meta.to_s][:actual_mean.to_s]]
        @table << ["Variance",         @values[:meta.to_s][:variance.to_s]]
        @table << ["Standart mistake", @values[:meta.to_s][:mistake.to_s]]
        @table << ["Delta",            @values[:meta.to_s][:delta.to_s]]
        @table << ["Border",           @values[:meta.to_s][:border.to_s]]
        @table << ["Quality",          @values[:meta.to_s][:quality.to_s]]
        @table << ["PDF: Win",         @values[:meta.to_s][:pdf.to_s][:success.to_s]]
        @table << ["PDF: Lose",        @values[:meta.to_s][:pdf.to_s][:failure.to_s]]
      end
    end
  end
end
