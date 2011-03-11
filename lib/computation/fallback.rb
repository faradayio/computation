module BrighterPlanet
  module Computation
    module Fallback
      def self.included(base)
        base.falls_back_on :duration => 3600.0 # assume 1 hour
      end
    end
  end
end
