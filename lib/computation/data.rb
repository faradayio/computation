module BrighterPlanet
  module Computation
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            float   'compute_time'
            integer 'compute_units'
            string  'zip_code_name'
            float   'compute_electricity_intensity'
            float   'power_usage_effectiveness'
          end
          
          process :run_data_miner_on_belongs_to_associations
        end
      end
    end
  end
end
