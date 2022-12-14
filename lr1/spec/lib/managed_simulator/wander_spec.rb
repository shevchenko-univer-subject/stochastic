RSpec.describe ManagedSimulator::Wander do 
  after(:each) do 
    experiment = described_class::Experiment.call(data)
    statistic = Wander::Statistic.call(experiment.collected_data)
    statistic.data.keys.each do |situation|
      delta = (statistic.probability[situation] - statistic.data.dig(situation, :exit_prob)).abs
      border = statistic.data.dig(situation, :uncertainty) * 3
      expect(delta).to be <= border
    end
  end

  describe 'symmetry' do
    describe 'without stopping' do
      let(:data) do 
        {
          meta: {
            sample_size: nil,
            space_size: {
              x: 10,
              y: 10
            },
            start_position: {
              x: 5,
              y: 5
            }
          },
          probability: {
            stopped: 0,
            north:   0.25,
            south:   0.25,
            east:    0.25,
            west:    0.25
          }
        }
      end 

      example 'has small sample size' do 
        data[:meta].merge!(sample_size: 10)
      end

      example 'has large sample size' do
        data[:meta].merge!(sample_size: 10000)
      end
    end

    describe 'with stopping' do 
      let(:data) do 
        {
          meta: {
            sample_size: 10000,
            space_size: {
              x: 10,
              y: 10
            },
            start_position: {
              x: 5,
              y: 5
            }
          },
          probability: nil
        }
      end

      example 'which weak' do 
        probability = {
          probability: {
            stopped: 0.04,
            north:   0.24,
            south:   0.24,
            east:    0.24,
            west:    0.24
          }
        }
        data.merge!(probability)
      end

      example 'which hard' do 
        probability = {
          probability: {
            stopped: 0.2,
            north:   0.2,
            south:   0.2,
            east:    0.2,
            west:    0.2
          }
        }
        data.merge!(probability)
      end
    end
  end

  describe 'one-dimensional horizontal wandering' do 
    let(:data) do 
      {
        meta: {
          sample_size: 10000,
          space_size: {
            x: 10,
            y: 10
          },
          start_position: {
            x: 5,
            y: nil
          }
        },
        probability: {
          stopped: 0,
          north:   0,
          south:   0.5,
          east:    0,
          west:    0.5
        }
      }
    end 

    example 'has symmetry position' do 
      data[:meta][:start_position].merge!(y: 5)
    end
    example 'has asymmetry position' do 
      data[:meta][:start_position].merge!(y: 3)
    end
  end
end
