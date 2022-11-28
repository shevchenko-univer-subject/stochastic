class Stochastic < Sinatra::Base
  module Controllers
    class Application
      def self.method_missing(method_name, *args)
        new.public_method(method_name).call(*args)
      end

      attr_reader :response, :view_name

      def index
        @view_name = :index

        self
      end

      def docs
        @view_name = :docs

        self
      end

      def tutor
        @view_name = :tutor

        self
      end

      def process(request)
        params = prepare_params(request)

        distribution = MODELS::BernoulliDistribution.new do |dist|
          dist.cdf  = params[:cdf]
          dist.pdf  = params[:pdf]
          dist.mean = params[:mean]
          dist.mode = params[:mode]
        end

        distribution.process

        @response = distribution.result

        self
      end

      def csv_create(request)
        params = prepare_params(request)

        csv_creator = MODELS::CsvCreator.new do |csv|
          csv.table = params
        end
        csv_creator.create
        link = request.env["HTTP_ORIGIN"] + '/export/' + csv_creator.name
        @response = link

        self
      end

      private

      def prepare_params(request)
        request.params
      end
    end
  end
end