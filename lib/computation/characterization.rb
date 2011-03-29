module BrighterPlanet
  module Computation
    module Characterization
      def self.included(base)
        base.characterize do
          has :date
          has :duration
          has :carrier
          has :carrier_region
          has :carrier_instance_class
          has :zip_code
          has :electricity_intensity
          has :power_usage_effectiveness
        end
      end
    end
  end
end
