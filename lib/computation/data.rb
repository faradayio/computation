module BrighterPlanet
  module Computation
    module Data
      def self.included(base)
        base.col :date, :type => :date
        base.col :duration, :type => :float
        base.col :computation_carrier_name
        base.col :computation_carrier_region_name
        base.col :computation_carrier_instance_class_name
        base.col :zip_code_name
        base.col :electricity_intensity, :type => :float
        base.col :power_usage_effectiveness, :type => :float
      end
    end
  end
end