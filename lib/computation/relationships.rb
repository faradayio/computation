require 'earth/computation/computation_carrier'
require 'earth/computation/computation_carrier_instance_class'
require 'earth/computation/computation_carrier_region'
require 'earth/locality/zip_code'

module BrighterPlanet
  module Computation
    module Relationships
      def self.included(base)
        base.send :belongs_to, :carrier,                :class_name => 'ComputationCarrier',              :foreign_key => 'computation_carrier_name'
        base.send :belongs_to, :carrier_region,         :class_name => 'ComputationCarrierRegion',        :foreign_key => 'computation_carrier_region_name'
        base.send :belongs_to, :carrier_instance_class, :class_name => 'ComputationCarrierInstanceClass', :foreign_key => 'computation_carrier_instance_class_name'
        base.send :belongs_to, :zip_code,                                                                 :foreign_key => 'zip_code_name'
      end
    end
  end
end
