module BrighterPlanet
  module Computation
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            float :compute_time
          end

          process :run_data_miner_on_belongs_to_associations
        end
      end
    end
  end
end
