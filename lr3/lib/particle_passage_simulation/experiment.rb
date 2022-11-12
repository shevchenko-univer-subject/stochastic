# frozen_string_literal: true

require_relative 'statistic'

module ParticlePassageSimulation
  class Experiment
    attr_reader :statistic
    NORMAL_DISTRTIBUTION = []
    def self.call(*args)
      new(*args).call
    end

    def initialize(data)
      @quantity = data[:quantity]
      @meta = data[:meta]
      @character = data[:character]

      @statistic = {
        back: 0,
        forward: 0,
        absorption: 0
      }
    end

    def call
      @quantity.times do |n|
        p n
        loop do
          current_position = @meta[:coocrdinate]
          current_cos_angle = @meta[:cos_radiation_angle]

          current_position =+ calculate_offset(current_cos_angle) 
          
          break record_run_back    if run_back?(current_position)
          break record_run_forward if run_forward?(current_position)
          break record_absorption  if absorption?(current_position)

          current_cos_angle = calculate_new_cos_angle(current_cos_angle)
        end
      end
    end

    private 

    def deviation_of(middle_value, _operator = nil)
      # random = rand
      # variance
      # standart_deviation = (random - middle_value) ** 2 

      middle_value
    end

    def calculate_offset(angle)
      length = deviation_of(@character[:middle_length])

      length * angle
    end

    def calculate_new_cos_angle(cos_angle)
      cos_scattering_angle = deviation_of(@character[:middle_cos_scattering_angle])

      lambda_new_cos_angle(cos_angle, cos_scattering_angle)
    end

    def lambda_new_cos_angle(prev, nexd)
      prev*nexd - Math.sqrt((1 - prev ** prev) * (1 - nexd ** nexd))
    end

    def run_back?(position)
      position < 0
    end

    def run_forward?(position)
      position > @meta[:substance_thickness]
    end

    def absorption?(position)
      rand <= @character[:absorption_probability]
    end

    def record_run_back
      @statistic[:back] += 1
    end        


    def record_run_forward
      @statistic[:forward] += 1
    end        


    def record_absorption
      @statistic[:absorption] += 1
    end        
  end
end
