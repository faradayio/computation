module BrighterPlanet
  module Computation
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            date   'date'
            float  'duration'
            string 'computation_carrier_name'
            string 'computation_carrier_region_name'
            string 'computation_carrier_instance_class_name'
            string 'zip_code_name'
            float  'electricity_intensity'
            float  'power_usage_effectiveness'
          end
          
          process :run_data_miner_on_belongs_to_associations
        end
      end
    end
  end
end
