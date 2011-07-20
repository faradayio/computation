module BrighterPlanet
  module Computation
    module Data
      def self.included(base)
        base.force_schema do
          date   'date'
          float  'duration'
          string 'computation_carrier_name'
          string 'computation_carrier_region_name'
          string 'computation_carrier_instance_class_name'
          string 'zip_code_name'
          float  'electricity_intensity'
          float  'power_usage_effectiveness'
        end
      end
    end
  end
end
