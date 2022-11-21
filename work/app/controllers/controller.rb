require "#{models}/bernoulli_distribution"
require "#{models}/csv/creator"
require "#{models}/csv/destroyer"

class Controller
  def self.method_missing(method_name, *args)
    new(*args).method(method_name).call
  end

  attr_reader :response, :view_name

  def index
    @view_name = :index
  end

  def docs
    @view_name = :docs
  end

  def tutor
    @view_name = :tutor
  end

  def process(params)
    distribution = BernoulliDistribution.new do |bd|
      bd.cdf = params[:cdf]
      bd.pdf = params[:pdf],
      bd.mean = params[:mean],
      bd.mode = params[:mode])
    end.process

    @response = distribution.result
  end

  def csv_create(params)
    csv_creator = Csv::Creator.new do |csv|
      csv.table = params[:table]
    end.create

    @response = csv_creator.link
  end

  def csv_destroy(params)
    csv_destroyer = Csv::Destroyer.new do |csv|
      csv.path = params[:path]
    end.destroy
  end
end