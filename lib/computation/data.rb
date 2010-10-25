module BrighterPlanet
  module Computation
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            float   'duration'
            integer 'ec2_compute_units'
            string  'zip_code_name'
            float   'electricity_intensity'
            float   'power_usage_effectiveness'
          end
          
          process :run_data_miner_on_belongs_to_associations
        end
      end
    end
  end
end
