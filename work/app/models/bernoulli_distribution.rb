class Stochastic < Sinatra::Base  
  module Models
    class BernoulliDistribution
      attr_accessor(
        :result
      )

      attr_reader :result
      
      def initialize
        if block_given?
          yield(self)
        else
          raise "need initialize object via block"
        end

        @result = initialize_result
      end

      def process 
        success = 0
        failure = 0

        @n.times do
          current_rand = rand
          next success += 1 if current_rand.between?(0, @p) 
          next failure += 1 if current_rand.between?(@p, 1) 
        end

        build_result(success, failure)
        floorize_values(@result)
        STDOUT.puts(@result)
        self
      end

      def result 
        process unless result_builded?

        chart_data = build_chart_data

        {
          meta: @result,
          chart: chart_data
        }
      end

      def quantity=(n)
        validate_quantity(n)

        @n = n
      end

      def probability=(prob)
        validate_probability(prob)

        @p = prob
      end

      def quantity
        @n
      end

      def probability
        @p
      end

      private

      def build_result(success, failure)
        @result[:expect_mean] = @p
        @result[:actual_mean] = success/@n.to_f

        @result[:variance] = @p * (1 - @p)
        @result[:mistake] = Math.sqrt((@p * (1 - @p))/@n)

        @result[:delta] = (@result[:expect_mean] - @result[:actual_mean]).abs
        @result[:border] = @result[:mistake].to_f

        @result[:quality] = (@result[:delta] <= @result[:border])

        @result[:probability][:success] = success/@n.to_f
        @result[:probability][:failure] = failure/@n.to_f
        
        @result[:pdf][:success] = build_pdf(@result[:probability][:success], 1)
        @result[:pdf][:failure] = build_pdf(@result[:probability][:failure], 0)
      end

      def floorize_values(current_hash)
        current_hash.each do |k, v|
          next floorize_values(v) if v.is_a? Hash
          next if v.is_a?(TrueClass) || v.is_a?(FalseClass)
          current_hash[k] = v.to_f.floor(4)
        end
      end

      def build_pdf(prob, x)
        prob**x * (1 - prob)**(1 - x)
      end

      def build_chart_data
        {
          x: ['lose', 'win'],
          y: [ @result[:probability][:failure], @result[:probability][:success] ] 
        }
      end

      def result_builded?
        @result[:expect_mean] &&
        @result[:variance] &&
        @result[:probability][:success] &&
        @result[:probability][:failure] &&
        @result[:pdf][:success] &&
        @result[:pdf][:success] 
      end

      def initialize_result
        {
          pdf: {
            success: nil,
            failure: nil
          },
          mean: nil,
          variance: nil,
          probability: {
            success: nil,
            failure: nil
          }
        }
      end

      def validate_probability(prob)
        unless prob.is_a? Float and prob.between?(0, 1)
          raise "prob need to be between 0 and 1"
        end
      end

      def validate_quantity(n)
        unless n.is_a? Integer 
          raise "prob need to be Intager type"
        end
      end

    end
  end
end