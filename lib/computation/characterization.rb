require 'characterizable'

module BrighterPlanet
  module Computation
    module Characterization
      def self.included(base)
        base.characterize do
          has :compute_time
          has :compute_units
          has :zip_code
          has :compute_electricity_intensity
          has :power_usage_effectiveness
        end
      end
    end
  end
end
