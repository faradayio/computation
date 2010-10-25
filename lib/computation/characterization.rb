require 'characterizable'

module BrighterPlanet
  module Computation
    module Characterization
      def self.included(base)
        base.characterize do
          has :duration
          has :ec2_compute_units
          has :zip_code
          has :electricity_intensity
          has :power_usage_effectiveness
        end
      end
    end
  end
end
