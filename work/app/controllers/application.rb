require 'sinatra/base'

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

        distribution = MODELS::BernoulliDistribution.new # TODO: block initialize

        distribution.cdf = params[:cdf]
        distribution.pdf = params[:pdf]
        distribution.mean = params[:mean]
        distribution.mode = params[:mode]

        distribution.process

        @response = distribution.result

        self
      end

      def csv_create(request)
        params = prepare_params(request)

        csv_creator = MODELS::Csv::Creator.new
        csv_creator.table = params[:table]
        csv_creator.create

        @response = csv_creator.link

        self
      end

      def csv_destroy(request)
        params = prepare_params(request)

        csv_destroyer = MODELS::Csv::Destroyer.new
        csv_destroyer.path = params[:path]

        csv_destroyer.destroy

        self
      end

      private

      def prepare_params(request)
        request.params
      end
    end
  end
end