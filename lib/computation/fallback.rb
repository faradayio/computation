module BrighterPlanet
  module Computation
    module Fallback
      def self.included(base)
        base.falls_back_on :duration                  => 3600.0, # assume 1 hour
                           :ec2_compute_units         => 1, # assume 1 EC2 Unit
                           :power_usage_effectiveness => 1.5, # based on Amazon's EC2 cost comparison calculator statement that most data centers have PUE of 1.3 - 3.0
                           :electricity_intensity     => 0.075 # kW based on Amazon's EC2 cost comparison calculator stating 150W for small compute instance equivalent server and 0.5 power conversion factor (to get average operating load from nameplate capacity) - EC2 probably has lower draw but higher power conversion factor
      end
    end
  end
end
